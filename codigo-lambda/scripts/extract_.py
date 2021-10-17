import json
import pandas as pd
import boto3


class Extract:
    def start(self, name):
        self.name = name
        try:
            data = self.__load_object()
            if '.json' in self.name:
                data = data['Body'].read().decode('utf-8')
                return self.__read_json(data)
            elif'.csv' in self.name:
                data = data['Body']
                return self.__read_csv(data)
            else:
                print('Error en el formato permitido para el consumo de los archivos')
        except Exception as e:
            print(e)
          
    def __load_object(self):
        s3_obj = boto3.client('s3')
        s3_clientobj = s3_obj.get_object(Bucket='test', Key=self.name)
        return s3_clientobj

    def __read_csv(self, data):
        df = pd.read_csv(data, sep=',')
        return df
    
    def __read_json(self, data):
        data = json.loads(data)
        df = pd.json_normalize(data['datos'])
        return df