
/**
 * This function is designed to wait for an HTML element specified by a CSS selector to be displayed on the page. 
 * It utilizes a recursive loop to continuously check for the presence of the element until it is found or a timeout occurs.
 * 
 * @param selector String The CSS selector of the HTML element to wait for.
 * @param callback Function The function to be called once the specified element is displayed.
 * @param checkFrequency Number The interval (ms) between each attempt to check for the element's presence.
 * @param timeOut Number|null The maximum time (ms) to wait for the element, if not provided than wait indefinitely.
 */
function citationManagerWaitForElementToDisplay(selector, callback, checkFrequency, timeOut) {
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
