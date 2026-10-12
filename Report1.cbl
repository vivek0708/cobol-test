       IDENTIFICATION DIVISION.
       PROGRAM-ID. REPORT01.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT INPUT-FILE ASSIGN TO 'EMPLOYEE.DAT'
               ORGANIZATION IS LINE SEQUENTIAL.
           SELECT REPORT-FILE ASSIGN TO 'REPORT.OUT'
               ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
       FD INPUT-FILE.
       01 EMPLOYEE-REC.
           05 EMP-ID        PIC X(05).
           05 EMP-NAME      PIC X(20).
           05 EMP-SALARY    PIC 9(7)V99.
   * Later you can add: 05 EMP-DEPT PIC X(10).

       FD REPORT-FILE.
       01 REPORT-LINE      PIC X(80).

       WORKING-STORAGE SECTION.
       01 WS-LINE          PIC X(80).
       01 WS-HEADER        PIC X(80) VALUE
           'EMPLOYEE REPORT - ID   NAME                 SALARY'.

       PROCEDURE DIVISION.
       BEGIN.
           OPEN INPUT INPUT-FILE
                OUTPUT REPORT-FILE.

           WRITE REPORT-LINE FROM WS-HEADER.

           PERFORM UNTIL EOF
               READ INPUT-FILE
                   AT END
                       MOVE 'Y' TO EOF
                   NOT AT END
                       PERFORM FORMAT-LINE
               END-READ
           END-PERFORM.

           CLOSE INPUT-FILE REPORT-FILE.
           STOP RUN.

       FORMAT-LINE.
           STRING EMP-ID DELIMITED BY SIZE
                  SPACE
                  EMP-NAME DELIMITED BY SIZE
                  SPACE
                  EMP-SALARY DELIMITED BY SIZE
                  INTO WS-LINE
           END-STRING.

           WRITE REPORT-LINE FROM WS-LINE.
