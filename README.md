# Monorepo-Structure
Learning Monorepo structure for Microservices architecture 

POC for Monorepo

# Monorepo POC - Java with Spring Boot

## 📌 Overview
This project demonstrates a **Monorepo** setup using **Java, Spring Boot, and Gradle**. It includes multiple modular services and a shared library to facilitate code reuse and maintainability.

---

## 📁 Project Structure

```
mr1n8l-monorepo-structure/
├── README.md
├── gradlew
├── gradlew.bat
├── buildSrc/
├── gradle/
│   └── wrapper/
├── settings.gradle
├── build.gradle
├── project-1/
│   ├── src/main/java/com/example/project1/
│   ├── build.gradle
├── project-2/
│   ├── src/main/java/com/example/project2/
│   ├── build.gradle
└── shared/
    ├── src/main/java/com/example/shared/
    ├── build.gradle
```


- **Project-1** and **Project-2**: Independent Spring Boot microservices.
- **Shared**: Contains reusable utilities or configurations.
- **Gradle**: Manages dependencies across projects.

---

## 🚀 Setup & Installation
### Prerequisites
- JDK 21
- Gradle 8.10
- Docker (Optional for containerization)

### Steps to Run
1. **Clone the Repository:**
   ```sh
   git clone https://github.com/your-repo/mr1n8l-monorepo-structure.git
   cd mr1n8l-monorepo-structure
   ```
2. **Build the Project:**
   ```sh
   ./gradlew build
   ```
3. **Run Services:**
   ```sh
   ./gradlew :project-1:bootRun
   ./gradlew :project-2:bootRun
   ```
4. **Access APIs:**
   - `Project-1`: [http://localhost:8081/hello](http://localhost:8081/hello)
   - `Project-2`: [http://localhost:8082/greet](http://localhost:8082/greet)

---

## 📦 Dependencies Management
- **Spring Boot Starter Web**: Provides web capabilities.
- **Shared Module**: Reusable utility services used by both projects.
- **Centralized Dependency Management**: Ensures consistency across all services.

---

## 🛠️ CI/CD & Deployment
(Optional based on requirements)
- **Docker Support** (Add Dockerfiles in each service).
- **CI/CD using GitHub Actions or Jenkins**.

---

## 📝 Future Enhancements
- Add **Spring Cloud** for better service discovery.
- Implement **Kubernetes** for container orchestration.
- Improve **Logging & Monitoring** using ELK stack.

---

## 👥 Contributors
- Mrinal Jani
