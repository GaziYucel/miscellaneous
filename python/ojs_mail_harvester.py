import csv
import os
from datetime import datetime
import requests
import xml.etree.ElementTree as ET
import smtplib
import dns.resolver

SENDER_EMAIL = "noreply@tib.eu"
CACHE_DIR = "cache"
INPUT_CSV = "journals_in.csv"
OUTPUT_CSV = "journals_out.csv"
CSV_HEADER = ["oai_url", "repository_name", "base_url", "admin_email", "version", "verified", "log"]

NAMESPACE = {
    'oai': "http://www.openarchives.org/OAI/2.0/",
    'toolkit': "http://oai.dlib.vt.edu/OAI/metadata/toolkit"
}

def prepare_url(url):
    url_new = url.replace("http://", "https://")
    if "verb=Identify" in url_new:
        return url_new
    return f"{url_new}&verb=Identify" if "?" in url_new else f"{url_new}?verb=Identify"

def get_cache_file_name(url):
    file_name = url
    replacements = {
        "?verb=Identify": "",
        "http://": "",
        "https://": "",
        "-": "_",
        "/": "-"
    }
    for old, new in replacements.items():
        file_name = file_name.replace(old, new)
    return os.path.join(CACHE_DIR, f"done_{file_name}.xml")

def get_journal_data(url):
    try:
        headers = {"User-Agent": "Mozilla/5.0"}
        response = requests.get(url, headers=headers, timeout=20)
        response.raise_for_status()
        print(f"{url} > {response.status_code}")
        response_body = getattr(response, "text", "")

        tree = ET.fromstring(response_body)

        def get_text(tag, ns='oai'):
            return getattr(tree.find(f".//{{{NAMESPACE[ns]}}}{tag}"), "text", "").strip()

        return response_body, {
            "repository_name": get_text("repositoryName"),
            "base_url": get_text("baseURL"),
            "admin_email": get_text("adminEmail"),
            "version": get_text("version", "toolkit"),
            "log": ""
        }

    except (requests.RequestException, ET.ParseError, Exception) as e:
        print(f"Error processing {url}: {e}")
        return "", {
            "repository_name": "",
            "base_url": "",
            "admin_email": "",
            "version": "",
            "log": str(e).replace('"', "'")
        }

def verify_email(email):
    domain = email.split('@')[1]
    try:
        mx_records = dns.resolver.resolve(domain, 'MX')
        mx_record = str(mx_records[0].exchange)

        server = smtplib.SMTP()
        server.timeout = 10
        server.set_debuglevel(0)
        server.connect(mx_record)
        server.helo()
        server.mail(SENDER_EMAIL)
        code, message = server.rcpt(email)
        server.quit()

        return code == 250
    except Exception as e:
        return False

def backup_file(filepath):
    if os.path.exists(filepath):
        timestamp = datetime.now().strftime("%Y%m%d%H%M%S")
        os.rename(filepath, f"{filepath}_{timestamp}")

def process_csv(input_csv, output_csv):
    os.makedirs(CACHE_DIR, exist_ok=True)
    backup_file(output_csv)

    with open(input_csv, 'r', encoding='utf-8') as infile, open(output_csv, 'w', encoding='utf-8',
                                                                newline='') as outfile:
        reader = csv.DictReader(infile)
        writer = csv.DictWriter(outfile, fieldnames=CSV_HEADER)
        writer.writeheader()

        for row in reader:
            oai_url = row.get("oai_url", "").strip()
            if not oai_url:
                continue

            if os.path.exists(get_cache_file_name(oai_url)):
                print(f"already processed > {oai_url}")
                continue

            full_url = prepare_url(oai_url)
            response_body, data = get_journal_data(full_url)

            if data["repository_name"] and data["admin_email"]:
                status = verify_email(data["admin_email"])
                data["verified"] = status

            with open(get_cache_file_name(oai_url), "w", encoding="utf-8") as cache_file:
                cache_file.write(response_body)

            writer.writerow({"oai_url": oai_url, **data})

# Entry point
process_csv(INPUT_CSV, OUTPUT_CSV)
