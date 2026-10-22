
CREATE TABLE departments (
                             id BIGINT PRIMARY KEY AUTO_INCREMENT,
                             name VARCHAR(100) NOT NULL,
                             code VARCHAR(20) NOT NULL UNIQUE,
                             created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE sections (
                          id BIGINT PRIMARY KEY AUTO_INCREMENT,
                          department_id BIGINT NOT NULL,
                          name VARCHAR(50) NOT NULL,
                          created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
                          CONSTRAINT fk_sections_department
                              FOREIGN KEY (department_id) REFERENCES departments(id),
                          CONSTRAINT uk_section_department_name
                              UNIQUE (department_id, name)
);

CREATE TABLE students (
                          id BIGINT PRIMARY KEY AUTO_INCREMENT,
                          department_id BIGINT NOT NULL,
                          section_id BIGINT,
                          name VARCHAR(150) NOT NULL,
                          roll_number VARCHAR(50) NOT NULL,
                          email VARCHAR(150),
                          active BOOLEAN NOT NULL DEFAULT TRUE,
                          created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
                          updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
                              ON UPDATE CURRENT_TIMESTAMP,
                          CONSTRAINT fk_students_department
                              FOREIGN KEY (department_id) REFERENCES departments(id),
                          CONSTRAINT fk_students_section
                              FOREIGN KEY (section_id) REFERENCES sections(id),
                          CONSTRAINT uk_student_roll_department
                              UNIQUE (department_id, roll_number)
);

CREATE TABLE admin_users (
                             id BIGINT PRIMARY KEY AUTO_INCREMENT,
                             name VARCHAR(150) NOT NULL,
                             email VARCHAR(150) NOT NULL UNIQUE,
                             password_hash VARCHAR(255) NOT NULL,
                             role VARCHAR(30) NOT NULL,
                             active BOOLEAN NOT NULL DEFAULT TRUE,
                             created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
                             CONSTRAINT chk_admin_role
                                 CHECK (role IN ('COLLEGE_ADMIN', 'DEPARTMENT_ADMIN'))
);

CREATE TABLE admin_department_access (
                                         admin_user_id BIGINT NOT NULL,
                                         department_id BIGINT NOT NULL,
                                         created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                         PRIMARY KEY (admin_user_id, department_id),
                                         CONSTRAINT fk_access_admin
                                             FOREIGN KEY (admin_user_id) REFERENCES admin_users(id),
                                         CONSTRAINT fk_access_department
                                             FOREIGN KEY (department_id) REFERENCES departments(id)
);
