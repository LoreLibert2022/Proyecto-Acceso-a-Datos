CREATE DATABASE soaDB;

CREATE TABLE Ocupacion(
    id_ocupacion INT AUTO_INCREMENT,
    descripcion VARCHAR(20),
    PRIMARY KEY(id_ocupacion)
);

CREATE TABLE Persona(
    id_persona INT AUTO_INCREMENT,
    id_ocupacion INT,
    nombre VARCHAR(40) NOT NULL,
    apellidos VARCHAR(40) NOT NULL,
    dni VARCHAR(9) NOT NULL,
    telefono_contacto VARCHAR(12),
    telefono_emergencias VARCHAR(12),
    fecha_nac DATE NOT NULL,
    direccion VARCHAR(50),
    cp INT,
    email VARCHAR(30),
    datos_salud VARCHAR(200),
    foto VARCHAR(255),
    fecha_inscrip_soa DATE NOT NULL,
    aficiones VARCHAR(200),
    usuario_instag VARCHAR(40),
    usuario_faceb VARCHAR(40),
    fecha_baja DATE,
    discapacidad_S/N BOOLEAN,
    tipo_discapacidad VARCHAR,
    PRIMARY KEY (id_persona),
    CONSTRAINT FK_id_ocupacion FOREIGN KEY(id_ocupacion) REFERENCES Ocupacion(id_ocupacion)
);

CREATE TABLE Deportista(
    id_deportista INT AUTO_INCREMENT,
    id_persona INT,
    PRIMARY KEY (id_deportista),
    CONSTRAINT FK_id_persona FOREIGN KEY(id_persona) REFERENCES Persona(id_persona)
);

CREATE TABLE Tipo_Voluntario(
    id_tipo_voluntario INT AUTO_INCREMENT,
    descripcion VARCHAR(30) NOT NULL,
    PRIMARY KEY(id_tipo_voluntario)
);

CREATE TABLE Voluntario(
    id_voluntario INT AUTO_INCREMENT,
    id_persona INT,
    id_tipo_voluntario INT,
    PRIMARY KEY (id_voluntario),
    CONSTRAINT FK_id_persona FOREIGN KEY(id_persona) REFERENCES Persona(id_persona),
    CONSTRAINT FK_id_tipo_voluntario FOREIGN KEY(id_tipo_voluntario) REFERENCES Tipo_Voluntario(id_tipo_voluntario)
);

CREATE TABLE Documentacion(
    id_documentacion INT AUTO_INCREMENT,
    descripcion VARCHAR(100) NOT NULL,
    PRIMARY KEY (id_documentacion)
);

CREATE TABLE Documentacion_por_voluntario(
    ubicacion VARCHAR(255),
    id_voluntario INT,
    id_documentacion INT,
    PRIMARY KEY(id_voluntario, id_documentacion),
    CONSTRAINT FK_id_voluntario FOREIGN KEY(id_voluntario) REFERENCES Voluntario(id_voluntario),
    CONSTRAINT FK_id_documentacion FOREIGN KEY(id_documentacion) REFERENCES Documentacion(id_documentacion)
);

CREATE TABLE Materiales(
    id_material INT AUTO_INCREMENT,
    nombre VARCHAR(30) NOT NULL,
    PRIMARY KEY(id_material) 
);

CREATE TABLE Entrega_material_voluntario(
    id_entrega_material INT AUTO_INCREMENT,
    fecha DATE NOT NULL,
    motivo VARCHAR(30),
    PRIMARY KEY(id_entrega_material),
    CONSTRAINT FK_id_voluntario FOREIGN KEY(id_voluntario) REFERENCES  Voluntario(id_voluntario)
);

CREATE TABLE Materiales_por_entrega(
    id_entrega_material INT,
    id_material INT,
    descripcion VARCHAR(30),
    PRIMARY KEY(id_entrega_material, id_material),
    CONSTRAINT FK_id_entrega_material FOREIGN KEY(id_entrega_material) REFERENCES Entrega_material_voluntario(id_entrega_material),
    CONSTRAINT FK_id_material FOREIGN KEY(id_material) REFERENCES Materiales(id_material)
);

CREATE TABLE Talla(
    id_talla INT AUTO_INCREMENT,
    descripcion VARCHAR(6) NOT NULL,
    PRIMARY KEY(id_talla),
    UNIQUE(descripcion)
);

CREATE TABLE Talla_por_voluntario(
    id_voluntario INT,
    id_material INT,
    id_talla INT NOT NULL,
    PRIMARY KEY(id_voluntario, id_material),
    CONSTRAINT FK_id_voluntario FOREIGN KEY(id_voluntario) REFERENCES Voluntario(id_voluntario),
    CONSTRAINT FK_id_material FOREIGN KEY(id_material) REFERENCES Materiales(id_material),
    CONSTRAINT FK_id_talla FOREIGN KEY(id_talla) REFERENCES Talla(id_talla)
);

CREATE TABLE Homologado(
    id_homologado INT AUTO_INCREMENT,
    nombre VARCHAR(50),
    PRIMARY KEY (id_homologado),
    UNIQUE(nombre)
);


CREATE table Entidad(
    id_entidad INT AUTO_INCREMENT,
    nombre VARCHAR(40) NOT NULL,
    PRIMARY KEY (id_entidad),
    UNIQUE(nombre)
);

CREATE table Curso(
    id_curso INT AUTO_INCREMENT,
    id_homologado INT,
    id_entidad INT,
    nombre VARCHAR(40) NOT NULL,
    descripcion VARCHAR(100),
    horas NUMERIC(3,2),
    PRIMARY KEY (id_curso),
    CONSTRAINT FK_id_homologado FOREIGN KEY(id_homologado) REFERENCES Homologado(id_homologado),
    CONSTRAINT FK_id_entidad FOREIGN KEY(id_entidad) REFERENCES Entidad(id_entidad)
);

CREATE TABLE Formacion(
    id_voluntario INT,
    id_curso INT,
    fecha DATE,
    PRIMARY KEY(id_voluntario,id_curso),
    CONSTRAINT FK_id_voluntario FOREIGN KEY(id_voluntario) REFERENCES Voluntario(id_voluntario),
    CONSTRAINT FK_id_curso FOREIGN KEY(id_curso) REFERENCES Curso(id_curso)
);

CREATE TABLE Tipo_actividad(
    id_tipo_actividad INT AUTO_INCREMENT,
    nombre VARCHAR(25) NOT NULL,
    PRIMARY KEY(id_tipo_actividad),
    UNIQUE(nombre)
);

CREATE TABLE Actividad(
    id_actividad INT AUTO_INCREMENT,
    id_entidad INT,
    id_tipo_actividad INT,
    fecha DATE,
    lugar VARCHAR(30),
    duracion NUMERIC(3,2),
    notas VARCHAR(100),
    PRIMARY KEY(id_actividad),
    CONSTRAINT FK_id_entidad FOREIGN KEY(id_entidad) REFERENCES Entidad(id_entidad),
    CONSTRAINT FK_id_tipo_actividad FOREIGN KEY(id_tipo_actividad) REFERENCES Tipo_actividad(id_tipo_actividad)
);

CREATE TABLE Voluntarios_por_actividad(
    id_voluntario INT,
    id_actividad INT,
    funcion VARCHAR(30),
    notas VARCHAR(100),
    PRIMARY KEY(id_voluntario, id_actividad),
    CONSTRAINT FK_id_voluntario FOREIGN KEY(id_voluntario) REFERENCES Voluntario(id_voluntario),
    CONSTRAINT FK_id_actividad FOREIGN KEY(id_actividad) REFERENCES Actividad(id_actividad)
);