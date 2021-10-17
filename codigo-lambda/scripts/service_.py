from .extract_ import Extract
from .persistence_ import Persistence

class Service:
    def __init__(self):
        self.db = Persistence()
        self.ext = Extract()

    def start_process(self, name):
        tables = self.db.get_tables()
        if (self.__validate_table(tables, name)):
            data = self.ext.start(name)
            values = [tuple(row) for row in data.values.tolist()]
            self.db.insert_data(values, name)
            print(f'Archivo {name}, terminado')
            self.db.close()
        print('Proceso terminado')

    def __validate_table(self, tables, name):
        if name in tables:
            """TODO EN CASO DE REQUERIR CALCULAR EL DELTA DE LOS NUEVOS DATOS ESTARÍAN
            EN ESTA PARTE"""
            return True
        else:
            self.db.create_table(name)
            return True
