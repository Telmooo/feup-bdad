import random
import time
from os.path import abspath, join, dirname

full_path = lambda filename: abspath(join(dirname(__file__), filename))

OUTFILE = full_path("database.txt")

DATE_FORMAT = "%d/%m/%Y %H:%M:%S"

FILES = {
    'M': full_path("male_firstname.txt"),
    'F': full_path("female_firstname.txt"),
    'last': full_path("all_lastname.txt"),
    'diseases': full_path("diseases.txt"),
    'spec': full_path("specializations.txt")
}

N_PATIENTS = 300
N_NURSE = 66
N_TECH = 16
N_DOCTORS = 44
START_ROOM = 100
N_ROOMS = 150
N_DISEASES = 0
N_SPEC = 0
N_SCHEDULES = 0
DAY_SCHEDULES = []

BLOOD_TYPE = ["O-", "O+", "A-", "A+", "B-", "B+", "AB-", "AB+"]
HEALTH_SUBSYS = ["ADSE", "PSP", "GNR", "SSMJ"]
WEEK_DAYS = ["Segunda", "Terca", "Quarta", "Quinta", "Sexta", "Sabado", "Domingo"]

SEP = "\n\n"

def init_diseases(output):
    global N_DISEASES
    output.write("-- Diseases\n")
    with open(FILES['diseases']) as diseases_file:
        for line in diseases_file:
            disease, desc, sympt = (line.split('\n'))[0].split('|')
            N_DISEASES += 1
            output.write(f"INSERT INTO Doenca (DoencaID, Nome, Descricao, Sintomas) VALUES ({N_DISEASES}, \"{disease}\", \"{desc}\", \"{sympt}\");\n")

def init_spec(output):
    global N_SPEC
    output.write("-- Specialities\n")
    with open(FILES['spec']) as specs_file:
        for line in specs_file:
            spec = (line.split('\n'))[0]
            N_SPEC += 1
            output.write(f"INSERT INTO Especializacao (EspecializacaoID, Nome) VALUES ({N_SPEC}, \"{spec}\");\n")
            
def init_rooms(output):
    i = 0
    output.write("-- Rooms\n")
    while (i < N_ROOMS):
        output.write(f"INSERT INTO Quarto (Numero) VALUES ({START_ROOM + i});\n")
        i += 1
        
def init_subsys(output):
    i = 1
    output.write("-- Health Subsystems\n")
    for subsys in HEALTH_SUBSYS:
        output.write(f"INSERT INTO SubsistemaSaude (SubsistemaSaudeID, Nome) VALUES ({i}, \"{subsys}\");\n")
        i += 1

def get_random_schedule_hour(fromHour):
    minute = random.choice([0, 15, 30, 45])
    hour = min(fromHour + random.choice([4, 6, 8, 10, 12]), 23)
    if (hour == 23 and hour - fromHour < 4):
        minute = 59
        
    return hour, minute


def init_schedule(output):
    output.write("-- Schedule\n")
    global N_SCHEDULES
    for day in WEEK_DAYS:
        day_sched = 0
        beginH, beginM = 0, 0
        while (beginM != 23 and beginM != 59):
            endH, endM = get_random_schedule_hour(beginH)
            begin = str(beginH).zfill(2) + ":" + str(beginM).zfill(2)
            end = str(endH).zfill(2) + ":" + str(endM).zfill(2)
            N_SCHEDULES += 1
            day_sched += 1
            output.write(f"INSERT INTO Horario (HorarioID, DiaSemana, HoraInicio, HoraFim) VALUES ({N_SCHEDULES}, \"{day}\", \"{begin}\", \"{end}\");\n")
            beginH, beginM = endH, endM
        DAY_SCHEDULES.append(day_sched)

def get_name(filename):
    selected = random.random() * 90
    with open(filename) as name_file:
        for line in name_file:
            name, _, cummulative, _ = line.split()
            if float(cummulative) > selected:
                return name

def get_random_bloodtype():
    return random.choice(BLOOD_TYPE)

def get_random_subsys():
    r = random.random()
    return 1 if r < 0.7 else 2 + int(random.random() * len(HEALTH_SUBSYS[1:]))

def get_random_schedule(day):
    return 1 + sum(DAY_SCHEDULES[:day]) + int(random.random() * DAY_SCHEDULES[day])

def get_first_name(gender):
    return get_name(FILES[gender]).capitalize()


def get_last_name():
    return get_name(FILES['last']).capitalize()


def get_full_name(gender):
    return f"{get_first_name(gender)} {get_last_name()}"

def get_random_spec():
    return 1 + int(random.random() * N_SPEC)

def random_date(start, end):
    
    proportion = random.random()

    stime = time.mktime(time.strptime(start, DATE_FORMAT))
    etime = time.mktime(time.strptime(end, DATE_FORMAT))

    ptime = stime + proportion * (etime - stime)

    return time.strftime(DATE_FORMAT, time.localtime(ptime))

def get_random_doctor():
    return 1 + N_PATIENTS + N_TECH + N_NURSE + int(random.random() * N_DOCTORS)

def generate_persons(output):
    global N_PATIENTS
    global N_NURSE
    global N_DOCTORS
    total = N_PATIENTS + N_NURSE + N_TECH + N_DOCTORS

    phones = random.sample(range(910000000, 1000000000), total)
    ccs = random.sample(range(10000000, 100000000), total)
    num_benef = random.sample(range(100000000, 1000000000), total)
    staff_id = random.sample(range(1000, 10000), N_NURSE + N_TECH + N_DOCTORS)
    
    i = 0
    #patients
    output.write("-- Patients\n")
    while (i < N_PATIENTS):
        phone = phones[i]
        cc = ccs[i]
        numbenef = num_benef[i]
        gender = random.choice(('M', 'F'))
        name = get_full_name(gender)
        birth = random_date("01/01/1970 00:00:00", "31/12/2019 23:59:59")
        address = "morada"
        output.write(f"INSERT INTO Pessoa (PessoaID, NumIdentificacao, Nome, Morada, Telefone, NumeroBeneficiario, Sexo, DataNascimento) VALUES ({i+1}, {cc}, \"{name}\", \"{address}\", {phone}, {numbenef}, \"{gender}\", \"{birth}\");\n")
        
        bloodt = get_random_bloodtype()
        r = random.random()
        if (r < 0.4):
            health_sub = get_random_subsys()
            output.write(f"INSERT INTO Paciente (PessoaID, GrupoSanguineo, SubsistemaSaude) VALUES ({i+1}, \"{bloodt}\", {health_sub});\n")
        else:
            output.write(f"INSERT INTO Paciente (PessoaID, GrupoSanguineo) VALUES ({i+1}, \"{bloodt}\");\n")
        
        
        i+=1
    
    #nurse
    output.write(SEP)
    output.write("-- Nurses\n")
    while (i < N_PATIENTS+N_NURSE):
        phone = phones[i]
        cc = ccs[i]
        numbenef = num_benef[i]
        gender = random.choice(('M', 'F'))
        name = get_full_name(gender)
        birth = random_date("01/01/1970 00:00:00", "31/12/2019 23:59:59")
        address = "morada"
        output.write(f"INSERT INTO Pessoa (PessoaID, NumIdentificacao, Nome, Morada, Telefone, NumeroBeneficiario, Sexo, DataNascimento) VALUES ({i+1}, {cc}, \"{name}\", \"{address}\", {phone}, {numbenef}, \"{gender}\", \"{birth}\");\n")
        
        staffid = staff_id[i-N_PATIENTS]
        spec = get_random_spec()
        output.write(f"INSERT INTO Staff (PessoaID, CodigoIdentificacao, Especializacao) VALUES ({i+1}, {staffid}, {spec});\n")
        
        output.write(f"INSERT INTO Enfermeiro (StaffID) VALUES ({staffid});\n")
        
        sched_count = 0
        for weekday in range(len(WEEK_DAYS)):
            r = random.random()
            
            if (r < 0.5):
                sched = get_random_schedule(weekday)
            
                output.write(f"INSERT INTO HorarioTrabalho (StaffID, HorarioID) VALUES ({staffid}, {sched});\n")
                sched_count+=1
            
            if sched_count == 6:
                break
        
        
        i+=1
        
    #tech
    output.write(SEP)
    output.write("-- Technicians\n")
    while (i < N_PATIENTS+N_NURSE+N_TECH):
        phone = phones[i]
        cc = ccs[i]
        numbenef = num_benef[i]
        gender = random.choice(('M', 'F'))
        name = get_full_name(gender)
        birth = random_date("01/01/1970 00:00:00", "31/12/2019 23:59:59")
        address = "morada"
        output.write(f"INSERT INTO Pessoa (PessoaID, NumIdentificacao, Nome, Morada, Telefone, NumeroBeneficiario, Sexo, DataNascimento) VALUES ({i+1}, {cc}, \"{name}\", \"{address}\", {phone}, {numbenef}, \"{gender}\", \"{birth}\");\n")
        
        staffid = staff_id[i-N_PATIENTS]
        spec = get_random_spec()
        output.write(f"INSERT INTO Staff (PessoaID, CodigoIdentificacao, Especializacao) VALUES ({i+1}, {staffid}, {spec});\n")
        
        output.write(f"INSERT INTO Tecnico (StaffID) VALUES ({staffid});\n")
        
        sched_count = 0
        for weekday in range(len(WEEK_DAYS)):
            r = random.random()
            
            if (r < 0.5):
                sched = get_random_schedule(weekday)
            
                output.write(f"INSERT INTO HorarioTrabalho (StaffID, HorarioID) VALUES ({staffid}, {sched});\n")
                sched_count+=1
            
            if sched_count == 6:
                break
        
        
        i+=1
    
    #doctors
    output.write(SEP)
    output.write("-- Doctors\n")
    used = [] # rooms used
    while (i < total):
        phone = phones[i]
        cc = ccs[i]
        numbenef = num_benef[i]
        gender = random.choice(('M', 'F'))
        name = get_full_name(gender)
        birth = random_date("01/01/1970 00:00:00", "31/12/2019 23:59:59")
        address = "morada"
        output.write(f"INSERT INTO Pessoa (PessoaID, NumIdentificacao, Nome, Morada, Telefone, NumeroBeneficiario, Sexo, DataNascimento) VALUES ({i+1}, {cc}, \"{name}\", \"{address}\", {phone}, {numbenef}, \"{gender}\", \"{birth}\");\n")
        
        staffid = staff_id[i-N_PATIENTS]
        spec = get_random_spec()
        output.write(f"INSERT INTO Staff (PessoaID, CodigoIdentificacao, Especializacao) VALUES ({i+1}, {staffid}, {spec});\n")
        
        if (len(used) < N_ROOMS):
            room = START_ROOM + int(random.random() * N_ROOMS)
            while (room in used):
                room = START_ROOM + int(random.random() * N_ROOMS)
            
            output.write(f"INSERT INTO Medico (StaffID, Consultorio) VALUES ({staffid}, {room});\n")
            used.append(room)
        else:
            output.write(f"INSERT INTO Medico (StaffID) VALUES ({staffid});\n")
        
        sched_count = 0
        for weekday in range(len(WEEK_DAYS)):
            r = random.random()
            
            if (r < 0.5):
                sched = get_random_schedule(weekday)
            
                output.write(f"INSERT INTO HorarioTrabalho (StaffID, HorarioID) VALUES ({staffid}, {sched});\n")
                sched_count+=1
            
            if sched_count == 6:
                break
        
        
        i+=1
        
    
def distribute_doctors(output):
    output.write("-- Distribution of doctors to patients\n")
    for j in range(1, N_PATIENTS + 1):
        r = random.random()
        
        if (r < 0.6):
            doc = get_random_doctor()
            output.write(f"INSERT INTO MedicoAtribuido (PacienteID, MedicoID) VALUES ({j}, {doc});\n")
        
    
def main():
    output = open(OUTFILE, "w")
    output.write("PRAGMA foreign_key = ON;\n")
    
    output.write(SEP)
    
    init_diseases(output)
    
    output.write(SEP)
    
    init_spec(output)
    
    output.write(SEP)
    
    init_rooms(output)
    
    output.write(SEP)
    
    init_subsys(output)
    
    output.write(SEP)
    
    init_schedule(output)
    
    output.write(SEP)
    
    generate_persons(output)
    
    output.write(SEP)
    
    distribute_doctors(output)
    
    output.close()
    
main()
    
