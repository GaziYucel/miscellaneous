/**
 * Checks if a given string is a valid JSON representation.
 *
 * @param {string} str - The string to be checked for JSON validity.
 * @returns {boolean} - True if the string is valid JSON, false otherwise.
 */
function isStringJson(str) {
    try {
        JSON.parse(str);
    } catch (e) {
        return false;
    }
    return true;
}

// Usage example

const validJsonString = '{"name": "John", "age": 30, "city": "New York"}';
const invalidJsonString = '{"name": "John", "age": 30, "city": "New York",}';

const isValidJson = isStringJson(validJsonString);
console.log(isValidJson); // Output: true

const isInvalidJson = isStringJson(invalidJsonString);
console.log(isInvalidJson); // Output: false
