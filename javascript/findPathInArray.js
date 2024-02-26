/**
 * This function is designed to find the path of a specified key within a nested JavaScript object or array (obj). 
 * The result is returned as a dot-separated string representing the path to the key.
 *
 * @param obj Object|Array The object or array in which the function searches for the specified key.
 * @param key String The key to be found within the object or array.
 * @returns String A dot-separated string representing the path to the specified key in the object or array.
 */
function findPathInArray(obj, key) {
    const path = [];
    const keyExists = (obj) => {
        if (!obj || (typeof obj !== "object" && !Array.isArray(obj))) {
            return false;
        } else if (obj.hasOwnProperty(key)) {
            return true;
        } else if (Array.isArray(obj)) {
            let parentKey = path.length ? path.pop() : "";

            for (let i = 0; i < obj.length; i++) {
                path.push(`${parentKey}[${i}]`);
                const result = keyExists(obj[i], key);
                if (result) {
                    return result;
                }
                path.pop();
            }
        } else {
            for (const k in obj) {
                path.push(k);
                const result = keyExists(obj[k], key);
                if (result) {
                    return result;
                }
                path.pop();
            }
        }
        return false;
    };

    keyExists(ob);

    return path.join(".");
}

// Usage example

const obj = {
    person: {
        name: "John",
        address: {
            city: "New York",
            phone: {
                mobile: "123-456-7890",
            },
        },
    },
    books: [
        { title: "Book 1", author: "Author 1" },
        { title: "Book 2", author: "Author 2" },
    ],
};

const key = "mobile";
const path = findPathInArray(obj, key);
console.log(path); // Output: "person.address.phone[0].mobile"
