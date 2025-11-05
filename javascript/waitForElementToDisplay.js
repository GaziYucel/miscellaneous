
/**
 * Waits for an HTML element to be present in the DOM and then execute a callback function.
 *
 * @param {string} selector - The CSS selector of the HTML element to wait for.
 * @param {function} callback - The function to be executed once the element is found.
 * @param {number} checkFrequency - The frequency (ms) at which to check for the element's presence.
 * @param {number} timeOut - The maximum time (ms) to wait for the element before giving up.
 */
function waitForElementToDisplay(selector, callback, checkFrequency, timeOut) {
    let startTime = Date.now();
    (function loopSearch() {
        if (document.querySelector(selector) != null) {
            callback();
        } else {
            setTimeout(function () {
                if (timeOut && Date.now() - startTime > timeOut)
                    return;
                loopSearch();
            }, checkFrequency);
        }
    })();
}

// Usage example

// Example usage to wait for an element with ID "myElement" to be displayed
const selector = '#myElement';

// Callback function to be executed when the element is found
const callback = function() {
    console.log('Element is displayed!');
};

// Check every 500 milliseconds for the element, and wait up to 5000 milliseconds (5 seconds)
const checkFrequency = 500;
const timeOut = 5000;

// Initiating the waiting process
waitForElementToDisplay(selector, callback, checkFrequency, timeOut);
