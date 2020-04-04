from random import randint as ri
from generate_database import random_date
from generate_database import main

main()

f = open('database.txt','a+')
data = open('../sql/povoar.sql','r')
medicos = []
tecnicos = []
enfermeiros = []
doencas = []

for line in data:
   if('INSERT INTO Medico (StaffID, Consultorio) VALUES (' in line):
      med = line[50:len(line)-3].split(',')
      medicos.append(int(med[0]))
   if('INSERT INTO Tecnico (StaffID) VALUES (' in line):
      tec = line[38:len(line)-3]
      tecnicos.append(int(tec))
   if('INSERT INTO Enfermeiro (StaffID) VALUES (' in line):
      enf = line[41:len(line)-3]
      enfermeiros.append(int(enf))
   if('INSERT INTO Doenca (DoencaID, Nome, Descricao, Sintomas) VALUES (' in line):
      d = line[65:len(line)-3].split(',')[1]
      d = d[2:-1]
      doencas.append(d)

f.write('''\n-- Departments
INSERT INTO Departamento (NumIdentificador,Nome,Responsavel) VALUES (1,"Cardiologia",311);
INSERT INTO Departamento (NumIdentificador,Nome,Responsavel) VALUES (2,"Triagem de mama",352);
INSERT INTO Departamento (NumIdentificador,Nome,Responsavel) VALUES (3,"Diagnóstico por imagem",389);
INSERT INTO Departamento (NumIdentificador,Nome,Responsavel) VALUES (4,"Otorrinolaringologia",360);
INSERT INTO Departamento (NumIdentificador,Nome,Responsavel) VALUES (5,"Geriatria",406);
INSERT INTO Departamento (NumIdentificador,Nome,Responsavel) VALUES (6,"Gastroenterologia",383);
INSERT INTO Departamento (NumIdentificador,Nome,Responsavel) VALUES (7,"Cirurgia geral",301);
INSERT INTO Departamento (NumIdentificador,Nome,Responsavel) VALUES (8,"Ginecologia",367);
INSERT INTO Departamento (NumIdentificador,Nome,Responsavel) VALUES (9,"Maternidade",323);
INSERT INTO Departamento (NumIdentificador,Nome,Responsavel) VALUES (10,"Microbiologia",314);
INSERT INTO Departamento (NumIdentificador,Nome,Responsavel) VALUES (11,"Neurologia",309);
INSERT INTO Departamento (NumIdentificador,Nome,Responsavel) VALUES (12,"Nutrição",302);
INSERT INTO Departamento (NumIdentificador,Nome,Responsavel) VALUES (13,"Obstetrícia",368);
INSERT INTO Departamento (NumIdentificador,Nome,Responsavel) VALUES (14,"Terapia Ocupacional",324);
INSERT INTO Departamento (NumIdentificador,Nome,Responsavel) VALUES (15,"Oncologia",387);
INSERT INTO Departamento (NumIdentificador,Nome,Responsavel) VALUES (16,"Oftalmologia",364);
INSERT INTO Departamento (NumIdentificador,Nome,Responsavel) VALUES (17,"Ortopedia",348);
INSERT INTO Departamento (NumIdentificador,Nome,Responsavel) VALUES (18,"Farmacologia",315);
INSERT INTO Departamento (NumIdentificador,Nome,Responsavel) VALUES (19,"Fisioterapia",318);
INSERT INTO Departamento (NumIdentificador,Nome,Responsavel) VALUES (20,"Radioterapia",390);
INSERT INTO Departamento (NumIdentificador,Nome,Responsavel) VALUES (21,"Unidade Renal",370);
INSERT INTO Departamento (NumIdentificador,Nome,Responsavel) VALUES (22,"Reumatologia",371);
INSERT INTO Departamento (NumIdentificador,Nome,Responsavel) VALUES (23,"Saude Sexual",372);
INSERT INTO Departamento (NumIdentificador,Nome,Responsavel) VALUES (24,"Urologia",377);\n''')

f.write("\n-- Admission\n")
for i in range(1,200):
   s = 'INSERT INTO Admissao (AdmissaoID, Data, Urgencia, Prioridade, Paciente) VALUES ({}, "{}", {}, {}, {});\n'

   di = random_date("01/01/1970 00:00:00", "31/12/2019 23:59:59")
   
   s = s.format(i,di,ri(0,3),ri(0,3),ri(1,300))
   
   f.write(s)


f.write("\n-- Occurrence\n")
for i in range(1,200):
   s = 'INSERT INTO Ocorrencia(OcorrenciaID, DataInicio, DataFim, Paciente, Doenca) VALUES ({}, "{}", "{}", {}, {});\n'

   di = random_date("01/01/1970 00:00:00", "31/12/2019 23:59:59")
   df = random_date(di, "31/12/2019 23:59:59")
   
   s = s.format(i,di,df,ri(1,300),ri(1,232))
   
   f.write(s)

f.write("\n-- Nurse Intervention\n")
for i in range(1,200):
   s = 'INSERT INTO Evento(EventoID,Descricao, Data, Admissao, Quarto) VALUES ({}, "descricao","{}" ,{}, {});\n'

   di = random_date("01/01/1970 00:00:00", "31/12/2019 23:59:59")
   a = ri(1,500)
   q = ri(100,249)
   s = s.format(i,di,a,q)

   s2 = 'INSERT INTO Intervencao( EventoID, Descricao) VALUES ({},"descricao");\n'
   s2 = s2.format(i)

   s3 = 'INSERT INTO EnfermeiroInterv( EnfermeiroID, IntervID) VALUES ({},{});\n'
   enfID = enfermeiros[ri(0,len(enfermeiros)-1)]
   s3 = s3.format(enfID,i)
   
   f.write(s)
   f.write(s2)
   f.write(s3)

f.write("\n-- Tecnician Intervention\n")
for i in range(200,500):
   s = 'INSERT INTO Evento(EventoID,Descricao, Data, Admissao, Quarto) VALUES ({}, "descricao","{}" ,{}, {});\n'

   di = random_date("01/01/1970 00:00:00", "31/12/2019 23:59:59")
   a = ri(1,500)
   q = ri(100,249)
   s = s.format(i,di,a,q)

   s2 = 'INSERT INTO Intervencao( EventoID, Descricao) VALUES ({},"descricao");\n'
   s2 = s2.format(i)

   s3 = 'INSERT INTO TecnicoInterv( TecnicoID, IntervID) VALUES ({},{});\n'
   tecID = tecnicos[ri(0,len(tecnicos)-1)]
   s3 = s3.format(tecID,i)
   
   f.write(s)
   f.write(s2)
   f.write(s3)

f.write("\n-- Medical Intervention\n")
for i in range(500,800):
   s = 'INSERT INTO Evento(EventoID,Descricao, Data, Admissao, Quarto) VALUES ({}, "descricao","{}" ,{}, {});\n'

   di = random_date("01/01/1970 00:00:00", "31/12/2019 23:59:59")
   a = ri(1,500)
   q = ri(100,249)
   s = s.format(i,di,a,q)

   s2 = 'INSERT INTO Intervencao( EventoID, Descricao) VALUES ({},"descricao");\n'
   s2 = s2.format(i)

   s3 = 'INSERT INTO MedicoInterv( MedicoID, IntervID) VALUES ({},{});\n'
   mID = medicos[ri(0,len(medicos)-1)]
   s3 = s3.format(mID,i)
   
   f.write(s)
   f.write(s2)
   f.write(s3)

exames = ['Sangue','Urina','liquido cefalorraquidiano','liquido sinovial','laringoscopia','broncoscopia','esofagoscopia','cistoscopia','laparoscopia','mediastinoscopia','toracoscopia']

f.write("\n-- Nurse Exam\n")
for i in range(800,950):
   s = 'INSERT INTO Evento(EventoID,Descricao, Data, Admissao, Quarto) VALUES ({}, "descricao","{}" ,{}, {});\n'

   di = random_date("01/01/1970 00:00:00", "31/12/2019 23:59:59")
   a = ri(1,500)
   q = ri(100,249)
   s = s.format(i,di,a,q)

   s2 = 'INSERT INTO Exame( EventoID, Nome, Descricao) VALUES ({},"{}","descricao");\n'
   s2 = s2.format(i,exames[ri(0,len(exames)-1)])

   s3 = 'INSERT INTO EnfermeiroExame( EnfermeiroID, ExameID) VALUES ({},{});\n'
   enfID = enfermeiros[ri(0,len(enfermeiros)-1)]
   s3 = s3.format(enfID,i)
   
   f.write(s)
   f.write(s2)
   f.write(s3)

f.write("\n-- Tecnician Exam\n")
for i in range(950,1211):
   s = 'INSERT INTO Evento(EventoID,Descricao, Data, Admissao, Quarto) VALUES ({}, "descricao","{}" ,{}, {});\n'

   di = random_date("01/01/1970 00:00:00", "31/12/2019 23:59:59")
   a = ri(1,500)
   q = ri(100,249)
   s = s.format(i,di,a,q)

   s2 = 'INSERT INTO Exame( EventoID, Nome, Descricao) VALUES ({},"{}","descricao");\n'
   s2 = s2.format(i,exames[ri(0,len(exames)-1)])

   s3 = 'INSERT INTO TecnicoExame( TecnicoID, ExameID) VALUES ({},{});\n'
   tecID = tecnicos[ri(0,len(tecnicos)-1)]
   s3 = s3.format(tecID,i)
   
   f.write(s)
   f.write(s2)
   f.write(s3)

f.write("\n-- Medical Exam\n")
for i in range(1211,1850):
   s = 'INSERT INTO Evento(EventoID,Descricao, Data, Admissao, Quarto) VALUES ({}, "descricao","{}" ,{}, {});\n'

   di = random_date("01/01/1970 00:00:00", "31/12/2019 23:59:59")
   a = ri(1,500)
   q = ri(100,249)
   s = s.format(i,di,a,q)

   s2 = 'INSERT INTO Exame( EventoID, Nome, Descricao) VALUES ({},"{}","descricao");\n'
   s2 = s2.format(i,exames[ri(0,len(exames)-1)])

   s3 = 'INSERT INTO MedicoExame( MedicoID, ExameID) VALUES ({},{});\n'
   mID = medicos[ri(0,len(medicos)-1)]
   s3 = s3.format(mID,i)
   
   f.write(s)
   f.write(s2)
   f.write(s3)

f.write("\n-- Consultation\n")
for i in range(1850,2300):
   diagnosticos = ['Mal estar','Virose','Infeccao bacteriana','Osso quebrado','Indeterminado','Catapora']*10 + doencas
   
   s = 'INSERT INTO Evento(EventoID,Descricao, Data, Admissao, Quarto) VALUES ({}, "descricao","{}" ,{}, {});\n'

   di = random_date("01/01/1970 00:00:00", "31/12/2019 23:59:59")
   a = ri(1,500)
   q = ri(100,249)
   s = s.format(i,di,a,q)

   s2 = 'INSERT INTO Consulta( EventoID, Diagnostico, Medico) VALUES ({},"{}",{});\n'
   mID = medicos[ri(0,len(medicos)-1)]
   s2 = s2.format(i,diagnosticos[ri(0,len(diagnosticos)-1)],mID)
   
   f.write(s)
   f.write(s2)

f.write("\n-- Internamento\n")
for i in range(1850,2300):
      
   s = 'INSERT INTO Evento(EventoID,Descricao, Data, Admissao, Quarto) VALUES ({}, "descricao","{}" ,{}, {});\n'

   di = random_date("01/01/1970 00:00:00", "31/12/2019 23:59:59")
   a = ri(1,500)
   q = ri(100,249)
   s = s.format(i,di,a,q)

   if(ri(0,100) < 70):
      df = random_date(di, "31/12/2019 23:59:59")
      s2 = 'INSERT INTO Internamento( EventoID, Motivo, DataFim, Ativo) VALUES ({},"{}","{}",0);\n'
      s2 = s2.format(i,doencas[ri(0,len(doencas)-1)],df)
   else:
      s2 = 'INSERT INTO Internamento( EventoID, Motivo, DataFim, Ativo) VALUES ({},"{}",NULL,1);\n'
      s2 = s2.format(i,doencas[ri(0,len(doencas)-1)])
   
   f.write(s)
   f.write(s2)

unique = []
f.write("\n-- Event Occourence\n")
for i in range(1,501):

   ev = ri(1,2399)
   if(ev in unique):
      continue
   unique.append(ev)
   
   s = 'INSERT INTO OcorrenciaEvento(OcorrenciaID,EventoID) VALUES ({}, {});\n'
   s = s.format(i,ev)
   
   f.write(s)
   
f.close()
data.close()
