// Require the necessary GTM APIs
const log = require('logToConsole');
const makeInteger = require('makeInteger');

// Get the values from the template's UI fields
const sourceText = data.sourceText;
const chunkNumber = makeInteger(data.chunkNumber);
const chunkSize = 100;

// Basic validation
if (!sourceText || chunkNumber < 1) {
  // If there's no source text or the chunk number is invalid, return undefined.
  return undefined;
}

// Calculate the start and end positions for the substring
const start = (chunkNumber - 1) * chunkSize;
const end = start + chunkSize;

// If the start position is beyond the length of the text, there's no chunk to return.
if (start >= sourceText.length) {
  return undefined;
}

// Extract and return the chunk of text
const chunk = sourceText.substring(start, end);
log('Returning chunk ' + chunkNumber + ': ' + chunk); // Logs to GTM's preview mode console
return chunk;
