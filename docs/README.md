README · MD
DOCUMENTACIÓN DE ABORDE DEL PROYECTO DEMO IOT

I&T Investigación y Tecnología

Rohus Suazo

-Contenido
-
<br>
-Introducción
<br>
-Repositorio GIT con Colaboradores
<br>
-README
<br>
-Definición de la Demo IoT y cómo Abordarlo
<br>
-Tecnologías que se utilizaran
<br>
-Cómo se conectan entre sí
<br>
-Entorno Simulado a decidir
<br>
-Script MySQL
<br>
-Conclusión
<br>
<br>

-Introducción
-
<br>
Demo IoT es una sección del sitio web de I&T, que todavía está en desarrollo. La idea es que los clientes puedan probar, de forma simulada e interactiva, cómo se controlan dispositivos IoT desde una interfaz web, con un panel de control integrado visualmente al resto del sitio. Este documento explica cómo vamos a trabajar el proyecto: el repositorio, el README, las tecnologías que se van a usar y las opciones que estamos evaluando para el entorno simulado.
<br>

-Repositorio GIT con Colaboradores
-
<br>
Para trabajar en equipo se crea un repositorio en GitHub y se agregan los colaboradores. Dentro del repositorio se entra a Settings y luego al apartado Collaborators. Más abajo, en Manage access, se aprieta Add people, se busca a la persona por su usuario o correo y se le envía la invitación. Cuando la acepta, ya puede subir cambios al repositorio.
<br>

-README
-
<br>
El README es el archivo que se muestra al entrar al repositorio y es lo primero que va a leer cualquier colaborador. Lo usaremos para explicar cómo iniciar y hacer andar el proyecto Demo IoT sin que se corrompa o genere errores. Ahí va a quedar qué hace el proyecto, lo que hay que tener instalado (por ejemplo Node.js y MySQL), los pasos para instalarlo y ejecutarlo, y un registro de los cambios que agrega cada colaborador.
<br>

-Definición de la Demo IoT y cómo Abordarlo
-
<br>
Demo IoT, como se dijo antes, será un entorno simulado que funcionará con un servidor con Socket.IO (más adelante se ven sus pros y contras). Los dispositivos serán simulados: el servidor generará lecturas cada cierto tiempo, por ejemplo de temperatura y humedad, y las enviará en tiempo real al panel de control. Desde el mismo panel también se podrán mandar órdenes, como encender o apagar un dispositivo. Para mostrar los datos se usará alguna de estas opciones: Tremor, Chart.js, Apache ECharts, TanStack Table o Volt React Dashboard. Como base se utilizará HTTPS para las peticiones (req, res), Node.js, React con Vite, Express, Knex y MySQL.
<br>

-Tecnologías que se utilizaran
-
<br>
<table> <tr> <td valign="top" width="30%"> <a href="https://socket.io/docs/v4/tutorial/introduction"><strong>Web socket (Socket.IO)</strong></a><br><br> La utilizaremos para la comunicación en tiempo real entre el servidor y el panel de control </td> <td valign="top" width="35%"> Pros;<br> -Bidireccional: el servidor y el cliente se pueden mandar datos cuando quieran.<br> -Basado en eventos (emit y on).<br> -No cacheable, los datos llegan siempre actualizados.<br> -Información de ida y vuelta entre el panel y el servidor.<br> -Se vuelve a conectar solo si se cae la conexión. </td> <td valign="top" width="35%"> Contras;<br> -Se cierra la conexión al salir de la página y no se guarda información, por eso los datos hay que guardarlos en la base de datos.<br> -Es una librería que va sobre WebSocket, no WebSocket puro: el cliente y el servidor tienen que usar Socket.IO.<br> -Si se quiere usar más de un servidor, necesita configuración extra. </td> </tr> <tr> <td valign="top"> <a href="https://expressjs.com/en/5x/starter/installing/"><strong>Express (node.js)</strong></a><br><br> La utilizaremos para manejar las peticiones y respuestas HTTPS (req, res) y armar la API del proyecto </td> <td valign="top"> Pros;<br> -Fácil de aprender y con mucha documentación.<br> -Las rutas y los middlewares son simples de armar.<br> -Se integra fácil con Socket.IO en el mismo servidor.<br> -Tiene muchos paquetes disponibles en npm. </td> <td valign="top"> Contras;<br> -No trae una estructura definida, el orden del proyecto depende de nosotros.<br> -La validación de datos y la seguridad se configuran a mano.<br> -Node.js usa un solo hilo, así que una tarea pesada puede bloquear el servidor. </td> </tr> <tr> <td valign="top"> <strong><a href="https://react.dev/learn">React</a> <a href="https://vite.dev/guide/">(vite)</a></strong><br><br> La utilizaremos para conectarnos con las diversas bibliotecas y armar el panel de control </td> <td valign="top"> Pros;<br> -Se arma con componentes que se pueden reutilizar (tarjetas, gráficos, tablas).<br> -La pantalla se actualiza sola cuando llegan datos nuevos.<br> -Vite inicia rápido y muestra los cambios al instante.<br> -Funciona con casi todas las bibliotecas que estamos evaluando. </td> <td valign="top"> Contras;<br> -Es solo la parte visual: las rutas y las llamadas al servidor necesitan otras bibliotecas.<br> -Algunas bibliotecas pueden dar problemas con versiones nuevas de React. </td> </tr> <tr> <td valign="top"> <a href="https://knexjs.org/guide/"><strong>Knex(node.js)</strong></a><br><br> La utilizaremos para que la conexión con MySQL sea más dinámica y ordenada </td> <td valign="top"> Pros;<br> -Las consultas se escriben en JavaScript y se leen más fácil que SQL suelto.<br> -Usa parámetros, lo que ayuda a evitar la inyección SQL.<br> -Tiene migraciones y seeds para versionar y llenar la base de datos.<br> -Si se cambia de motor de base de datos, el código casi no cambia. </td> <td valign="top"> Contras;<br> -Una consulta muy compleja puede quedar más difícil de leer que en SQL directo.<br> -Hay que aprender su sintaxis además de SQL. </td> </tr> <tr> <td valign="top"> <a href="https://dev.mysql.com/doc/mysql-getting-started/en/"><strong>Mysql</strong></a><br><br> La utilizaremos para la gestión y la creación de la base de datos donde se guardarán los dispositivos y sus lecturas </td> <td valign="top"> Pros;<br> -Es muy usado, estable.<br> -Las tablas y relaciones ordenan bien los datos (dispositivos y lecturas).<br> -Permite consultar y filtrar el historial de lecturas. </td> <td valign="top"> Contras;<br> -El esquema es rígido: cambiar la estructura requiere migraciones.<br> -Si los sensores mandan datos muy seguido, la tabla crece rápido y hay que limpiarla o usar índices.<br> -Hay que instalar y configurar el servidor de base de datos. </td> </tr> </table>
<br>

-Cómo se conectan entre sí
-
<br>
Los dispositivos simulados generan lecturas que el servidor (Express con Socket.IO) envía en tiempo real al panel hecho en React. Al mismo tiempo, el servidor guarda esos datos en MySQL usando Knex, para que el historial no se pierda cuando se cierra la conexión. Así el tiempo real lo maneja el socket y el almacenamiento lo maneja la base de datos.
<br>

-Entorno Simulado a decidir
-
<table> <tr> <td valign="top" width="30%"> <a href="https://www.tremor.so/docs/getting-started/installation"><strong>Tremor</strong></a> </td> <td valign="top" width="35%"> Pros;<br> -Dashboard con buena pinta en muy poco código.<br> -Tarjetas de KPI, badges de estado y gráficos vienen listos.<br> -Ideal para un panel de control rápido. </td> <td valign="top" width="35%"> Contras;<br> -Los gráficos son menos personalizables (usa Recharts por debajo).<br> -Necesita tener Tailwind configurado.<br> -Puede tener problemas de compatibilidad con versiones nuevas de React. </td> </tr> <tr> <td valign="top"> <a href="https://www.chartjs.org/docs/latest/getting-started/installation.html"><strong>Chart.js</strong></a> </td> <td valign="top"> Pros;<br> -Muy sencillo y muy documentado.<br> -Liviano. </td> <td valign="top"> Contras;<br> -Solo gráficos: no incluye tarjetas, tablas ni layout.<br> -Con datos en tiempo real y muchos puntos puede volverse más lento.<br> -Estilo más básico por defecto. </td> </tr> <tr> <td valign="top"> <a href="https://echarts.apache.org/handbook/en/basics/download"><strong>Apache Echarts</strong></a> </td> <td valign="top"> Pros;<br> -Muy potente en velocímetros, mapas, gráficos en tiempo real.<br> -Maneja bien muchos datos.<br> -Los velocímetros quedan muy bien para sensores de humedad o temperatura. </td> <td valign="top"> Contras;<br> -Más pesado y con una API más grande.<br> -Las opciones son un objeto enorme que cuesta recordar. </td> </tr> <tr> <td valign="top"> <a href="https://tanstack.com/table/latest/docs/installation"><strong>TanStack Table</strong></a> </td> <td valign="top"> Pros;<br> -Excelente para la lista de dispositivos con orden, filtros y paginación.<br> -Se combina con cualquier librería. </td> <td valign="top"> Contras;<br> - tú escribes todo el HTML y CSS, no vienen por defecto.<br> -Para algo simple puede ser exagerado. </td> </tr> <tr> <td valign="top"> <a href="https://themesberg.com/product/dashboard/volt-react"><strong>Volt React Dashboard</strong></a> </td> <td valign="top"> Pros;<br> -Plantilla completa: sidebar, navbar, páginas, tablas y gráficos ya hechos.<br> -Ahorra mucho tiempo de diseño. </td> <td valign="top"> Contras;<br> -Trae muchas cosas que no vamos a usar en un panel IoT.<br> -Está basada en Bootstrap y su estructura es fija, nos tendríamos que adaptar a ella.<br> -Puede traer dependencias antiguas que choquen con versiones nuevas de React. </td> </tr> </table>

-Script MySQL
-
Para crear el script de la base de datos se diseño tomando referencia del ejemplo propuesto por el supervisor jefe, el cual considero tres entidades(dispositivos/estados/eventos).
<br>
-Dispositivos; almacena el catálogo de dispositivos simulados, junto con su código, nombre, tipo, unidad de medida y ubicación.
-Estados; registra el estado actual de cada dispositivo y si se encuentra conectado o desconectado.
-Eventos; guarda el historial de acciones y lecturas, incluyendo el valor anterior y el nuevo, el origen del evento y la fecha y hora en que ocurrió.
<br>
Además, se recomienda más adelante alterar las tablas con los atributos TIMESTAMP por DATETIME , para evitar un mal funcionamiento, ya que TIMESTAMP tiene un rango más limitado de fechas. También tener en cuenta que id_sesion_eve es un texto que se genera en la aplicación ósea el backend creara un identificador aleatorio
<br>
<table> <tr> <td>
CREATE DATABASE db_demoiot;
<br>
USE db_demoiot;
<br>
<br>
CREATE TABLE dispositivos (
    <br>
    id_dispositivo INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    <br>
    codigo_dis VARCHAR(30) NOT NULL UNIQUE,
    <br>
    nombre_dis VARCHAR(100) NOT NULL,
    <br>
    tipo_dis ENUM ('LUZ', 'TEMPERATURA', 'EMERGENCIA') NOT NULL,
    <br>
    unidad_dis VARCHAR(20) DEFAULT NULL,
    <br>
    ubicacion_dis VARCHAR(100) DEFAULT NULL,
    <br>
    activo_dis TINYINT(1) NOT NULL DEFAULT 1,
    <br>
    creado_en_dis TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    <br>
);
<br>
<br>
CREATE TABLE estados (
    <br>
    id_estado INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    <br>
    id_dispositivo INT NOT NULL UNIQUE,
    <br>
    valor_est VARCHAR(50) NOT NULL,
    <br>
    conectado_est TINYINT(1) NOT NULL DEFAULT 0,
    <br>
    actualizado_en_est TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    <br>
    FOREIGN KEY (id_dispositivo) REFERENCES dispositivos (id_dispositivo)
    ON DELETE CASCADE
    <br>
);
<br>
<br>
CREATE TABLE eventos (
    <br>
    id_evento BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    <br>
    id_dispositivo INT NOT NULL,
    <br>
    tipo_eve ENUM ('CONTROL_LUZ', 'LECTURA_TEMP', 'EMERGENCIA') NOT NULL,
    <br>
    valor_previo_eve VARCHAR(50) DEFAULT NULL,
    <br>
    valor_nuevo_eve VARCHAR(50) NOT NULL,
    <br>
    valor_num_eve DECIMAL(6, 2) DEFAULT NULL,
    <br>
    origen_eve VARCHAR(30) NOT NULL,
    <br>
    id_sesion_eve VARCHAR(50) DEFAULT NULL,
    <br>
    registrado_en_eve TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    <br>
    FOREIGN KEY (id_dispositivo) REFERENCES dispositivos (id_dispositivo)
    ON DELETE CASCADE,
    <br>
    INDEX idx_eventos_dispositivo_fecha (id_dispositivo, registrado_en_eve),
    <br>
    INDEX idx_eventos_sesion (id_sesion_eve)
    <br>
);
</td> </tr> </table>
<br>

-Conclusión
-
<br>
Con lo visto hasta ahora, la base del proyecto queda definida: Socket.IO para la comunicación en tiempo real, Express y Node.js para el servidor, React con Vite para el panel de control, y Knex con MySQL para guardar los datos.<br>
La base de datos se diseñó a partir del ejemplo propuesto por el supervisor jefe, con tres tablas principales: dispositivos (catálogo con código, nombre, tipo, unidad y ubicación), estados (valor actual de cada dispositivo y si está conectado o desconectado) y eventos (historial de lecturas y acciones, con valor anterior y nuevo, origen y fecha). Para saber qué visitante realizó cada acción, la tabla de eventos incluye el campo id_sesion_eve, un texto que el backend genera como identificador aleatorio para cada visitante. Así no se necesita un sistema de login ni una tabla adicional de sesiones, lo que mantiene el diseño simple y adecuado para una demostración. Además, las relaciones usan ON DELETE CASCADE, de modo que al eliminar un dispositivo también se limpian sus estados y eventos asociados.<br>
Lo que falta decidir es qué biblioteca se usará para el entorno simulado. Por ahora, como sugerencia, la opción que más se ajusta es Chart.js, porque es sencilla, está muy documentada y alcanza para mostrar los datos en vivo. TanStack Table se puede sumar para la lista de dispositivos. Si más adelante se quiere un panel más completo, se puede cambiar a Tremor o a Apache ECharts sin tocar el servidor ni la base de datos. En cambio, Volt React Dashboard se deja de lado porque trae más de lo que se necesita.
