window.formVitals = (function() {
    'use strict';

    /**
     * Converts a FormData object into a plain JavaScript object.
     * It correctly handles multiple values for the same key (e.g., checkboxes)
     * by converting them into an array.
     * @param {FormData} formData The FormData object to convert.
     * @returns {Object} A plain JavaScript object representing the form data.
     */
    const getObjectFromFormData = (formData) => {
        const data = {};
        formData.forEach((value, key) => {
            console.log(value);
            console.log(key);
            // Check if the key already exists.
            if (Object.prototype.hasOwnProperty.call(data, key)) {
                console.log(data[key]);
                // If it's not already an array, convert it to one.
                if (!Array.isArray(data[key])) {
                    data[key] = [data[key]];
                }
                data[key].push(value);
            } else {
                data[key] = value;
            }
        });
        return data;
    };

    /**
     * Attaches a 'submit' event listener to all forms on the page.
     * When a form is submitted, it gathers metadata and form field data,
     * then passes it to the provided callback function.
     * @param {Function} callback The function to call with the form data report.
     */
    function onFormSubmit(callback) {
        if (typeof callback !== 'function') {
            console.error('FormVitals: The callback provided to onFormSubmit must be a function.');
            return;
        }

        // Find all forms on the page and attach the listener.
        document.querySelectorAll('form').forEach(form => {
            form.addEventListener('submit', (event) => {
                
                const formData = new FormData(form);
                console.log(formData);

                // Convert the FormData to a more accessible plain object.
                const dataObject = getObjectFromFormData(formData);
                console.log(dataObject);
                const formReport = {
                    formElement: form,
                    formId: form.id || null,
                    formName: form.name || null,
                    formAction: form.action,
                    formMethod: form.method,
                    timestamp: event.timeStamp,
                    data: dataObject,
                    originalEvent: event 
                };

                callback(formReport);
            });
        });
    }

    return {
        onFormSubmit: onFormSubmit
    };
})();
