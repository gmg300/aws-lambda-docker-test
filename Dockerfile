FROM public.ecr.aws/lambda/nodejs:12
 
COPY . ${LAMBDA_TASK_ROOT}

RUN npm install

ENV NODE_PATH=./dist

RUN npm run build

# You can overwrite command in `serverless.yml` template
CMD ["app.handler"]
