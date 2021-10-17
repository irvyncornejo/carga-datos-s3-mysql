import pymysql
import os

config = os.environ['CONFIG_DB']

class Persistence:
    def __init__(self):
        self.cnx = pymysql.connect(**config)
        self.cursor = self.cnx.cursor()
  
    def get_tables(self):
        self.cursor.execute("SHOW TABLES")
        tables = [name_table[0] for name_table in list(self.cursor)]
        return tables
  
    def create_table(self, name_table):
        query = f"""CREATE TABLE IF NOT EXISTS _TEST.`{name_table}` 
                (fecha varchar(25), ruta varchar(10), 
                ticket varchar(10), ocupacion double, 
                src varchar(10), dst varchar(100), d_src double,
                d_dst double, realizado varchar(6), estado varchar(10));"""
        self.cursor.execute(query)
  
  
    def insert_data(self, values, table_name):
        query = (f"""INSERT INTO `{table_name}` 
                (fecha,ruta,ticket,ocupacion,src,dst,d_src,d_dst,realizado,estado) 
                    VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s);""")
        val = values
        self.cursor.executemany(query, val)
        self.cnx.commit()
        return self.cursor.rowcount
  
  
    def close(self):
        self.cursor.close()
        self.cnx.close()
