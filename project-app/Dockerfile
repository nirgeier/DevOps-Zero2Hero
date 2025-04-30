FROM node:18

WORKDIR .

# Copy package files and install dependencies
COPY package*.json ./

RUN npm install

# Copy the rest of the code
COPY . .

# Expose the port your app runs on
EXPOSE 3000

# Start the app
CMD ["npm", "start"]
