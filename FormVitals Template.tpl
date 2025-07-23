___INFO___

{
  "type": "TAG",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "FormVitals Template",
  "brand": {
    "id": "brand_dummy",
    "displayName": ""
  },
  "description": "",
  "containerContexts": [
    "WEB"
  ]
}


___TEMPLATE_PARAMETERS___

[]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

// Enter your template code here.
const log = require('logToConsole');
const copyFromWindow = require('copyFromWindow');
const createQueue = require('createQueue');
const dataLayerName = 'dataLayer';
const injectScript = require('injectScript');
const Object = require('Object');

const cdnUrl = "https://jcma-google.github.io/google-tag-template/test.js";

const dataLayerPush = createQueue(dataLayerName);

const pushData = cwvObj => {
  // Remove entries property, otherwise GTM will return null values, because the type of entries is not supported.
  Object.delete(cwvObj, 'entries');
  // Store the cleaned object in a new constant.
  const cwvData = cwvObj;
  
  // Create the data layer object.
  const cwvDataLayerObject = {
    'event': 'formSubmitData',
    'formVitalsData': cwvData
  };
  
  dataLayerPush(cwvDataLayerObject);
  
};
const onFailure = () => {
  if (data.log) log('Form Vitals data failed to load.');
  data.gtmOnFailure();
};

const loadFormVitals = () => {
  const formVitals = copyFromWindow('formVitals');
  log(formVitals);
  if (formVitals) {
    formVitals.onFormSubmit(pushData);
    // if (data.cls || data.metrics === 'allMetrics') webVitalsGlobal.onCLS(pushData);
    // if (data.fcp || data.metrics === 'allMetrics') webVitalsGlobal.onFCP(pushData);
    //if (data.inp || data.metrics === 'allMetrics') webVitalsGlobal.onINP(pushData);
    //if (data.lcp || data.metrics === 'allMetrics') webVitalsGlobal.onLCP(pushData);
    //if (data.ttfb || data.metrics === 'allMetrics') webVitalsGlobal.onTTFB(pushData);
    data.gtmOnSuccess();
  } else {
   onFailure(); 
  }
};

injectScript(cdnUrl, loadFormVitals, onFailure);

// Call data.gtmOnSuccess when the tag is finished.
data.gtmOnSuccess();


___WEB_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "logging",
        "versionId": "1"
      },
      "param": [
        {
          "key": "environments",
          "value": {
            "type": 1,
            "string": "debug"
          }
        }
      ]
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "access_globals",
        "versionId": "1"
      },
      "param": [
        {
          "key": "keys",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "key"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  },
                  {
                    "type": 1,
                    "string": "execute"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "dataLayer"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": false
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "key"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  },
                  {
                    "type": 1,
                    "string": "execute"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "formVitals"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "inject_script",
        "versionId": "1"
      },
      "param": [
        {
          "key": "urls",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 1,
                "string": "https://jcma-google.github.io/google-tag-template/test.js"
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  }
]


___TESTS___

scenarios: []


___NOTES___

Created on 7/23/2025, 5:14:19 PM


