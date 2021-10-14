# carga-datos-s3-mysql
Proceso de extracción de archivos desde un bucket de s3; tales archivos pueden ser json o csv. Los procesa una función lambda y realizar la carga en una instancia de AWS Aurora

## Descripción del  proceso
Para la carga de datos implementé s3 para el almacenamiento de los archivos, para la extracción y carga; utilicé python y como base de datos usé Aurora en su versión MySQL 8.0.23.
La ejecución de la carga de información está dada por un trigger, configurado en el bucket de s3; al cargar o actualizar un archivo con extensión .json o .csv. La Función lambda recibe el nombre del documento que fue actualizado o se añadió y procesa la información para escribirla dentro de la base de datos relacional. Compara si la tabla  existe (el nombre de la tabla está dada por el nombre del archivo) y de no ser así la crea; y después carga los datos correspondientes. 

![Diagrama 1](https://drive.google.com/file/d/1nGNkD4PT8R4oHMhKrMyOxcMCq5wexjG-/view?usp=sharing)