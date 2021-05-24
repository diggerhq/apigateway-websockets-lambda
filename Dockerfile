FROM public.ecr.aws/lambda/nodejs:14
COPY package*.json /var/task/
RUN npm install
COPY . /var/task
EXPOSE 3000
ENV TABLE_NAME="digger-ws"
CMD [ "onConnect.handler" ]