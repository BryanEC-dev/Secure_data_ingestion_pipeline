# AWS Secure Data Ingestion Pipeline (DLP + Terraform)

## 📌 Descripción del Proyecto
Este proyecto implementa una arquitectura de ingesta de datos automatizada y segura en AWS utilizando **Infrastructure as Code (Terraform)**. El sistema actúa como un filtro de **Data Loss Prevention (DLP)** básico, analizando archivos subidos a un bucket de S3 y clasificándolos según la sensibilidad de su contenido mediante una función AWS Lambda.

El objetivo es demostrar habilidades en la automatización de infraestructura, seguridad de la información y lógica serverless.

---

## 🏗️ Arquitectura
La solución despliega los siguientes componentes:

* **Networking:** VPC configurada para el procesamiento seguro de datos.
* **Almacenamiento (S3):** * `Landing Bucket`: Punto de entrada para nuevos archivos.
    * `Clean Bucket`: Destino de archivos validados y seguros.
    * `Quarantine Bucket`: Aislamiento de archivos con datos sensibles detectados (PII).
* **Compute (Lambda):** Función en Python disparada por eventos de S3 que ejecuta la inspección mediante expresiones regulares (Regex).
* **Seguridad:** * Roles de **IAM** basados en el Principio de Menor Privilegio.
    * Encriptación de datos en reposo.
    * Monitoreo mediante **CloudWatch Logs**.

[Image of AWS S3 and Lambda DLP architecture diagram]

---

## 🛠️ Requisitos Previos
* AWS CLI configurado con credenciales de acceso.
* Terraform v1.0 o superior.
* Python 3.9+ para la lógica de la función Lambda.

## 🚀 Despliegue

1.  **Inicializar Terraform:**
    ```bash
    terraform init
    ```

2.  **Verificar el Plan:**
    ```bash
    terraform plan
    ```

3.  **Aplicar Infraestructura:**
    ```bash
    terraform apply --auto-approve
    ```

---

## 🧪 Pruebas de Validación (UAT)

| Escenario | Acción | Resultado Esperado |
| :--- | :--- | :--- |
| **Archivo Seguro** | Subir `limpio.txt` con texto común. | El archivo se mueve a `Clean Bucket`. |
| **Detección