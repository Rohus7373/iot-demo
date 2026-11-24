CREATE DATABASE db_demoiot;
USE db_demoiot;

CREATE TABLE dispositivos (
    id_dispositivo INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    codigo_dis VARCHAR(30) NOT NULL UNIQUE,
    nombre_dis VARCHAR(100) NOT NULL,
    tipo_dis ENUM ('LUZ', 'TEMPERATURA', 'EMERGENCIA') NOT NULL,
    unidad_dis VARCHAR(20) DEFAULT NULL,
    ubicacion_dis VARCHAR(100) DEFAULT NULL,
    activo_dis TINYINT(1) NOT NULL DEFAULT 1,
    creado_en_dis TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE estados (
    id_estado INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_dispositivo INT NOT NULL UNIQUE,
    valor_est VARCHAR(50) NOT NULL,
    conectado_est TINYINT(1) NOT NULL DEFAULT 0,
    actualizado_en_est TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (id_dispositivo) REFERENCES dispositivos (id_dispositivo)
    ON DELETE CASCADE
);

CREATE TABLE eventos (
    id_evento BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_dispositivo INT NOT NULL,
    tipo_eve ENUM ('CONTROL_LUZ', 'LECTURA_TEMP', 'EMERGENCIA') NOT NULL,
    valor_previo_eve VARCHAR(50) DEFAULT NULL,
    valor_nuevo_eve VARCHAR(50) NOT NULL,
    valor_num_eve DECIMAL(6, 2) DEFAULT NULL,
    origen_eve VARCHAR(30) NOT NULL,
    id_sesion_eve VARCHAR(50) DEFAULT NULL,
    registrado_en_eve TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_dispositivo) REFERENCES dispositivos (id_dispositivo)
    ON DELETE CASCADE,
    INDEX idx_eventos_dispositivo_fecha (id_dispositivo, registrado_en_eve),
    INDEX idx_eventos_sesion (id_sesion_eve)
);