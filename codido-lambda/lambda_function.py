import json

from scripts.service_ import Service

def lambda_handler(event, context):
    name_file = event['Records'][0]['s3']['object']['key']
    s = Service()
    s.start_process(name_file)
    
    return {
        'statusCode': 200,
        'body': json.dumps('Proceso de carga...')
    }