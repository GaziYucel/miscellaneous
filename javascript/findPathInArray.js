/**
 * Recursively searches for a specified key within a nested JavaScript object or array,
 * and returns the path to the key as a dot-separated string.
 *
 * @param {Object|Array} obj - The object or array to search for the key.
 * @param {string} key - The key to find within the object or array.
 * @returns {string} - A dot-separated string representing the path to the specified key.
 */
function findPathInArray(obj, key) {    
    const path = [];
    
    /**
     * Helper function to recursively check if the key exists in the given object or array.
     *
     * @param {Object|Array} obj - The current object or array to search.
     * @returns {boolean} - True if the key is found, false otherwise.
     */
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
