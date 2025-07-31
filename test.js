window.formVitals = (function() {
    'use strict';

    /**
     * Converts a FormData object into a plain JavaScript object.
     * It correctly handles multiple values for the same key (e.g., checkboxes)
     * by converting them into an array.
     * @param {FormData} formData The FormData object to convert.
     * @returns {Object} A plain JavaScript object representing the form data.
     */
    const getFormDataObject = (form) => {
      const data = {};
      Array.from(form.elements).forEach((field) => {
        const key = field.name || field.id;
    
        if (!key || field.disabled ||
          ["file", "reset", "submit", "button"].includes(field.type)
        ) {
          return;
        }
    
        if (field.type === "select-multiple") {
          data[key] = Array.from(field.options)
            .filter((option) => option.selected)
            .map((option) => option.value);
          return;
        }
    
        if (field.type === "checkbox") {
          if (!data[key]) {
            data[key] = [];
          }
          if (field.checked) {
            data[key].push(field.value);
          }
          return;
        }
    
        if (field.type === "radio") {
          if (field.checked) {
            data[key] = field.value;
          }
          return;
        }
        const piiRegex = /phone|email|name/i;
        if (!key.match(piiRegex)) {
            data[key] = field.value;
        }
      });
    
      // Clean up checkbox arrays: if an array has one item, flatten it. If empty, remove it.
      for (const key in data) {
        if (Array.isArray(data[key])) {
          if (data[key].length === 0) {
            delete data[key];
          } else if (data[key].length === 1) {
            data[key] = data[key][0];
          }
        }
      }
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
                const dataObject = getFormDataObject(form);
                console.log(dataObject);
                const formReport = {
                    formElement: form,
                    formId: form.id || null,
                    formName: form.name || null,
                    formAction: form.action,
                    formMethod: form.method,
                    timestamp: event.timeStamp,
                    data: JSON.stringify(dataObject),
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
