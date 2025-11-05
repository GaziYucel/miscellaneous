import csv
import smtplib
import dns.resolver

sender_email = "noreply@example.com"
input_csv = "verify.csv"
output_csv = "verify_out.csv"
csv_header = ["email", "verified"]


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
        server.mail(sender_email)
        code, message = server.rcpt(email)
        server.quit()

        return code == 250
    except Exception as e:
        return False


with open(input_csv, 'r', encoding='utf-8') as infile, open(output_csv, 'w', encoding='utf-8', newline='') as outfile:
    reader = csv.DictReader(infile)
    writer = csv.DictWriter(outfile, fieldnames=csv_header)
    writer.writeheader()

    for row in reader:
        row_out = row

        if row_out["email"]:
            status = verify_email(row_out["email"])
            row_out["verified"] = status

        print(str(row_out))
        writer.writerow(row_out)
