<%*

// 1. GET USER INPUT

// Prompt the user for the task details.

const input = await tp.system.prompt("Enter task: (-h|-n|-l) (-c color) text");

  

// If the user cancels the prompt or provides no input, exit silently.

if (!input) {

return "";

}

  
  

// 2. PARSE FLAGS AND MESSAGE

// Initialize the parts of our task.

let msg = input;

let prio = "@Prio(normal)";

let colorTag = "";

  

// Use a regular expression to find the priority flag (e.g., "-h ") and remove it from the message.

const prioMatch = msg.match(/^(-h|-n|-l)\s/);

if (prioMatch) {

const flag = prioMatch[1];

if (flag === '-h') prio = "@Prio(high)";

if (flag === '-l') prio = "@Prio(low)";

// If it's -n, it's already the default.

msg = msg.replace(prioMatch[0], ''); // Remove the flag from the start of the message.

}

  

// Use another regex to find the color flag (e.g., "-c red ") and remove it.

// This works even if the priority flag was also used.

const colorMatch = msg.match(/-c\s+(\w+)\s?/);

if (colorMatch) {

const colorName = colorMatch[1];

colorTag = `@Color(${colorName})`;

msg = msg.replace(colorMatch[0], ''); // Remove the color flag from the message.

}

  

// The remainder is the actual task text.

msg = msg.trim();

  
  

// 3. ASSEMBLE THE TASK STRING

// Get the current time.

const now = window.moment().format("YYYY-MM-DD HH:mm");

  

// Combine the tags, making sure not to add extra spaces if the color tag is not present.

const tags = [prio, colorTag].filter(Boolean).join(' ');

  

// Create the final task line.

const task = `- [ ] ${tags} ${msg} @${now}`;

  
  

// 4. APPEND TASK TO THE END OF THE FILE

// Get the current file object.

const file = tp.config.target_file;

// Read the existing content of the file.

const content = await app.vault.read(file);

  

let newContent;

if (content.trim() === '') {

// If the file is empty, the new task becomes the only content.

newContent = task;

} else {

// If the file has content, add the new task to the very end, on a new line.

// trimEnd() ensures we don't add extra blank lines if the file already ends with one.

newContent = content.trimEnd() + '\n' + task;

}

  

// Use the Obsidian API to overwrite the file with the updated content.

await app.vault.modify(file, newContent);

  
  

// Return an empty string. This is crucial!

// It tells Templater that we are done and prevents it from inserting any text at the cursor.

return "";

%>