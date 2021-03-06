PRAGMA foreign_keys=OFF;

DROP TABLE IF EXISTS Pessoa;
DROP TABLE IF EXISTS Staff;
DROP TABLE IF EXISTS Enfermeiro;
DROP TABLE IF EXISTS Tecnico;
DROP TABLE IF EXISTS Medico;
DROP TABLE IF EXISTS Especializacao;
DROP TABLE IF EXISTS Horario;
DROP TABLE IF EXISTS Departamento;
DROP TABLE IF EXISTS Paciente;
DROP TABLE IF EXISTS SubsistemaSaude;
DROP TABLE IF EXISTS Admissao;
DROP TABLE IF EXISTS Doenca;
DROP TABLE IF EXISTS Ocorrencia;
DROP TABLE IF EXISTS Quarto;
DROP TABLE IF EXISTS Evento;
DROP TABLE IF EXISTS Intervencao;
DROP TABLE IF EXISTS Exame;
DROP TABLE IF EXISTS Consulta;
DROP TABLE IF EXISTS Internamento;
DROP TABLE IF EXISTS HorarioTrabalho;
DROP TABLE IF EXISTS MedicoAtribuido;
DROP TABLE IF EXISTS EnfermeiroInterv;
DROP TABLE IF EXISTS EnfermeiroExame;
DROP TABLE IF EXISTS TecnicoInterv;
DROP TABLE IF EXISTS TecnicoExame;
DROP TABLE IF EXISTS MedicoInterv;
DROP TABLE IF EXISTS MedicoExame;
DROP TABLE IF EXISTS OcorrenciaEvento;

CREATE TABLE Pessoa (
        PessoaID            INTEGER CONSTRAINT PessoaPK PRIMARY KEY,
        NumIdentificacao    INTEGER NOT NULL UNIQUE,
        Nome                TEXT    NOT NULL,
        Morada              TEXT    NOT NULL,
        Telefone            INTEGER UNIQUE,
        NumeroBeneficiario  INTEGER NOT NULL UNIQUE,
        Sexo                TEXT    NOT NULL,
        DataNascimento      TEXT    NOT NULL
);

CREATE TABLE Staff (
        PessoaID            INTEGER CONSTRAINT StaffPK PRIMARY KEY,
        CodigoIdentificacao INTEGER NOT NULL UNIQUE,
        Especializacao      TEXT,
        CONSTRAINT StaffPessoaFK FOREIGN KEY (PessoaID)
            REFERENCES Pessoa (PessoaID)
                ON UPDATE CASCADE
                ON DELETE RESTRICT,
        CONSTRAINT StaffEspecializacaoFK FOREIGN KEY (Especializacao)
            REFERENCES Especializacao (EspecializacaoID)
                ON UPDATE CASCADE
                ON DELETE SET NULL
);

CREATE TABLE Enfermeiro (
        StaffID             INTEGER CONSTRAINT EnfermeiroPK PRIMARY KEY,
        CONSTRAINT EnfermeiroStaffFK FOREIGN KEY (StaffID)
            REFERENCES Staff (PessoaID)
                ON UPDATE CASCADE
                ON DELETE RESTRICT
);

CREATE TABLE Tecnico (
        StaffID             INTEGER CONSTRAINT TecnicoPK PRIMARY KEY,
        CONSTRAINT TecnicoStaffFK FOREIGN KEY (StaffID)
            REFERENCES Staff (PessoaID)
                ON UPDATE CASCADE
                ON DELETE RESTRICT
);

CREATE TABLE Medico (
        StaffID             INTEGER CONSTRAINT MedicoPK PRIMARY KEY,
        Consultorio         INTEGER UNIQUE,
        CONSTRAINT MedicoStaffFK FOREIGN KEY (StaffID)
            REFERENCES Staff (PessoaID)
                ON UPDATE CASCADE
                ON DELETE RESTRICT,
        CONSTRAINT MedicoQuartoFK FOREIGN KEY (Consultorio)
            REFERENCES Quarto (Numero)
                ON UPDATE CASCADE
                ON DELETE SET NULL
);

CREATE TABLE Especializacao (
        EspecializacaoID    INTEGER CONSTRAINT EspecializacaoPK PRIMARY KEY,
        Nome                TEXT    NOT NULL UNIQUE,
        Departamento        INTEGER,
        CONSTRAINT EspecializacaoDepartamentoFK FOREIGN KEY (Departamento)
            REFERENCES Departamento (NumIdentificador)
                ON UPDATE CASCADE
                ON DELETE SET NULL
);

CREATE TABLE Horario (
        HorarioID           INTEGER CONSTRAINT HorarioPK PRIMARY KEY,
        DiaSemana           TEXT    NOT NULL,
        HoraInicio          TEXT    NOT NULL,
        HoraFim             TEXT    NOT NULL,
        CONSTRAINT HorarioIgual UNIQUE(DiaSemana, HoraInicio, HoraFim),
        CONSTRAINT HorarioDatas CHECK (HoraInicio < HoraFim)
);

CREATE TABLE Departamento (
        NumIdentificador    INTEGER CONSTRAINT DepartamentoPK PRIMARY KEY,
        Nome                TEXT    NOT NULL,
        Responsavel         INTEGER NOT NULL UNIQUE,
        CONSTRAINT DepartamentoStaffFK FOREIGN KEY (Responsavel)
            REFERENCES Staff (PessoaID)
                ON UPDATE CASCADE
                ON DELETE RESTRICT
);

CREATE TABLE Paciente (
        PessoaID            INTEGER CONSTRAINT PacientePK PRIMARY KEY,
        GrupoSanguineo      TEXT    NOT NULL,
        SubsistemaSaude     TEXT,
        CONSTRAINT PacientePessoaFK FOREIGN KEY (PessoaID)
            REFERENCES Pessoa (PessoaID)
                ON UPDATE CASCADE
                ON DELETE RESTRICT,
        CONSTRAINT PacienteSubsistemaSaudeFK FOREIGN KEY (SubsistemaSaude)
            REFERENCES SubsistemaSaude (SubsistemaSaudeID)
                ON UPDATE CASCADE
                ON DELETE SET NULL
);

CREATE TABLE SubsistemaSaude (
        SubsistemaSaudeID   INTEGER CONSTRAINT SubsistemaSaudePK PRIMARY KEY,
        Nome                TEXT    NOT NULL UNIQUE
);

CREATE TABLE Admissao (
        AdmissaoID          INTEGER CONSTRAINT AdmissaoPK PRIMARY KEY,
        Data                TEXT    NOT NULL,
        Urgencia            INTEGER NOT NULL DEFAULT 0,
        Prioridade          INTEGER NOT NULL DEFAULT 0,
        Paciente            INTEGER NOT NULL,
        CONSTRAINT AdmissaoPacienteFK FOREIGN KEY (Paciente)
            REFERENCES Paciente (PessoaID)
                ON UPDATE CASCADE
                ON DELETE RESTRICT,
        CONSTRAINT MesmaAdmissao UNIQUE(Data, Paciente),
        CONSTRAINT UrgenciaPrioridade CHECK ((Urgencia == 0 AND Prioridade == 0) OR (Urgencia == 1 AND Prioridade > 0))
);

CREATE TABLE Doenca (
        DoencaID            INTEGER CONSTRAINT DoencaPK PRIMARY KEY,
        Nome                TEXT    NOT NULL UNIQUE,
        Descricao           TEXT    NOT NULL
);

CREATE TABLE Ocorrencia (
        OcorrenciaID        INTEGER CONSTRAINT OcorrenciaPK PRIMARY KEY,
        DataInicio          TEXT    NOT NULL,
        DataFim             TEXT,
        Paciente            INTEGER NOT NULL,
        Doenca              INTEGER NOT NULL,
        CONSTRAINT OcorrenciaPessoaFK FOREIGN KEY (Paciente)
            REFERENCES Paciente (PessoaID)
                ON UPDATE CASCADE
                ON DELETE RESTRICT,
        CONSTRAINT OcorrenciaDoencaFK FOREIGN KEY (Doenca)
            REFERENCES Doenca (DoencaID)
                ON UPDATE CASCADE
                ON DELETE RESTRICT,
        CONSTRAINT MesmaOcorrencia UNIQUE(DataInicio, Paciente, Doenca),
        CONSTRAINT OcorrenciaDataFim CHECK ((DataFim IS NULL) OR (DataInicio < DataFim))
);

CREATE TABLE Quarto (
        Numero              INTEGER CONSTRAINT QuartoPK PRIMARY KEY
);

CREATE TABLE Evento (
        EventoID            INTEGER CONSTRAINT EventoPK PRIMARY KEY,
        Descricao           TEXT    NOT NULL,
        Data                TEXT    NOT NULL,
        Admissao            INTEGER NOT NULL,
        Quarto              INTEGER NOT NULL,
        CONSTRAINT EventoAdmissaoFK FOREIGN KEY (Admissao)
            REFERENCES Admissao (AdmissaoID)
                ON UPDATE CASCADE
                ON DELETE RESTRICT,
        CONSTRAINT EventoQuartoFK FOREIGN KEY (Quarto)
            REFERENCES Quarto (Numero)
                ON UPDATE CASCADE
                ON DELETE RESTRICT
);

CREATE TABLE Intervencao (
        EventoID            INTEGER CONSTRAINT IntervencaoPK PRIMARY KEY,
        Descricao           TEXT    NOT NULL,
        CONSTRAINT IntervencaoEventoFK FOREIGN KEY (EventoID)
            REFERENCES Evento (EventoID)
                ON UPDATE CASCADE
                ON DELETE RESTRICT
);

CREATE TABLE Exame (
        EventoID            INTEGER CONSTRAINT ExamePK PRIMARY KEY,
        Nome                TEXT    NOT NULL,
        Descricao           TEXT    NOT NULL,
        CONSTRAINT ExameEventoFK FOREIGN KEY (EventoID)
            REFERENCES Evento (EventoID)
                ON UPDATE CASCADE
                ON DELETE RESTRICT
);

CREATE TABLE Consulta (
        EventoID            INTEGER CONSTRAINT ConsultaPK PRIMARY KEY,
        Diagnostico         TEXT    NOT NULL,
        Medico              INTEGER NOT NULL,
        CONSTRAINT ConsultaEventoFK FOREIGN KEY (EventoID)
            REFERENCES Evento (EventoID)
                ON UPDATE CASCADE
                ON DELETE RESTRICT,
        CONSTRAINT ConsultaMedicoFK FOREIGN KEY (Medico)
            REFERENCES Medico (StaffID)
                ON UPDATE CASCADE
                ON DELETE RESTRICT
);

CREATE TABLE Internamento (
        EventoID            INTEGER CONSTRAINT InternamentoPK PRIMARY KEY,
        Motivo              TEXT    NOT NULL,
        DataFim             TEXT,
        Ativo               INTEGER NOT NULL,
        CONSTRAINT InternamentoEventoFK FOREIGN KEY (EventoID)
            REFERENCES Evento (EventoID)
                ON UPDATE CASCADE
                ON DELETE RESTRICT,
        CONSTRAINT InternamentoEstado CHECK ((Ativo == 1 AND DataFim IS NULL) OR (Ativo == 0 AND DataFim IS NOT NULL))
);

CREATE TABLE HorarioTrabalho (
        StaffID             INTEGER,
        HorarioID           INTEGER,
        CONSTRAINT HorarioTrabalhoPK PRIMARY KEY (StaffID, HorarioID),
        CONSTRAINT HorarioTrabalhoStaffFK FOREIGN KEY (StaffID)
            REFERENCES Staff (PessoaID)
                ON UPDATE CASCADE
                ON DELETE CASCADE,
        CONSTRAINT HorarioTrabalhoHorarioFK FOREIGN KEY (HorarioID)
            REFERENCES Horario (HorarioID)
                ON UPDATE CASCADE
                ON DELETE CASCADE
);

CREATE TABLE MedicoAtribuido (
        PacienteID          INTEGER,
        MedicoID            INTEGER,
        CONSTRAINT MedicoAtribuidoPK PRIMARY KEY (PacienteID, MedicoID),
        CONSTRAINT MedicoAtribuidoPacienteFK FOREIGN KEY (PacienteID)
            REFERENCES Paciente (PessoaID)
                ON UPDATE CASCADE
                ON DELETE CASCADE,
        CONSTRAINT MedicoAtribuidoMedicoFK FOREIGN KEY (MedicoID)
            REFERENCES Medico (StaffID)
                ON UPDATE CASCADE
                ON DELETE CASCADE
);

CREATE TABLE EnfermeiroInterv (
        EnfermeiroID        INTEGER,
        IntervID            INTEGER,
        CONSTRAINT EnfermeiroIntervPK PRIMARY KEY (EnfermeiroID, IntervID),
        CONSTRAINT EnfermeiroIntervEnfermeiroFK FOREIGN KEY (EnfermeiroID)
            REFERENCES Enfermeiro (StaffID)
                ON UPDATE CASCADE
                ON DELETE CASCADE,
        CONSTRAINT EnfermeiroIntervIntervencaoFK FOREIGN KEY (IntervID)
            REFERENCES Intervencao (EventoID)
                ON UPDATE CASCADE
                ON DELETE CASCADE
);

CREATE TABLE EnfermeiroExame (
        EnfermeiroID        INTEGER,
        ExameID             INTEGER,
        CONSTRAINT EnfermeiroExamePK PRIMARY KEY (EnfermeiroID, ExameID),
        CONSTRAINT EnfermeiroExameEnfermeiroFK FOREIGN KEY (EnfermeiroID)
            REFERENCES Enfermeiro (StaffID)
                ON UPDATE CASCADE
                ON DELETE CASCADE,
        CONSTRAINT EnfermeiroExameExameFK FOREIGN KEY (ExameID)
            REFERENCES Exame (EventoID)
                ON UPDATE CASCADE
                ON DELETE CASCADE
);

CREATE TABLE TecnicoInterv (
        TecnicoID           INTEGER,
        IntervID            INTEGER,
        CONSTRAINT TecnicoIntervPK PRIMARY KEY (TecnicoID, IntervID),
        CONSTRAINT TecnicoIntervTecnicoFK FOREIGN KEY (TecnicoID)
            REFERENCES Tecnico (StaffID)
                ON UPDATE CASCADE
                ON DELETE CASCADE,
        CONSTRAINT TecnicoIntervIntervencaoFK FOREIGN KEY (IntervID)
            REFERENCES Intervencao (EventoID)
                ON UPDATE CASCADE
                ON DELETE CASCADE
);

CREATE TABLE TecnicoExame (
        TecnicoID           INTEGER,
        ExameID             INTEGER,
        CONSTRAINT TecnicoExamePK PRIMARY KEY (TecnicoID, ExameID),
        CONSTRAINT TecnicoExameTecnicoFK FOREIGN KEY (TecnicoID)
            REFERENCES Tecnico (StaffID)
                ON UPDATE CASCADE
                ON DELETE CASCADE,
        CONSTRAINT TecnicoExameExameFK FOREIGN KEY (ExameID)
            REFERENCES Exame (EventoID)
                ON UPDATE CASCADE
                ON DELETE CASCADE
);

CREATE TABLE MedicoInterv (
        MedicoID            INTEGER,
        IntervID            INTEGER,
        CONSTRAINT MedicoIntervPK PRIMARY KEY (MedicoID, IntervID),
        CONSTRAINT MedicoIntervMedicoFK FOREIGN KEY (MedicoID)
            REFERENCES Medico (StaffID)
                ON UPDATE CASCADE
                ON DELETE CASCADE,
        CONSTRAINT MedicoIntervIntervencaoFK FOREIGN KEY (IntervID)
            REFERENCES Intervencao (EventoID)
                ON UPDATE CASCADE
                ON DELETE CASCADE
);

CREATE TABLE MedicoExame (
        MedicoID            INTEGER,
        ExameID             INTEGER,
        CONSTRAINT MedicoExamePK PRIMARY KEY (MedicoID, ExameID),
        CONSTRAINT MedicoExameMedicoFK FOREIGN KEY (MedicoID)
            REFERENCES Medico (StaffID)
                ON UPDATE CASCADE
                ON DELETE CASCADE,
        CONSTRAINT MedicoExameExameFK FOREIGN KEY (ExameID)
            REFERENCES Exame (EventoID)
                ON UPDATE CASCADE
                ON DELETE CASCADE
);

CREATE TABLE OcorrenciaEvento (
        OcorrenciaID        INTEGER,
        EventoID            INTEGER,
        CONSTRAINT OcorrenciaEventoPK PRIMARY KEY (OcorrenciaID, EventoID),
        CONSTRAINT OcorrenciaEventoOcorrenciaFK FOREIGN KEY (OcorrenciaID)
            REFERENCES Ocorrencia (OcorrenciaID)
                ON UPDATE CASCADE
                ON DELETE CASCADE,
        CONSTRAINT OcorrenciaEventoEventoFK FOREIGN KEY (EventoID)
            REFERENCES Evento (EventoID)
                ON UPDATE CASCADE
                ON DELETE CASCADE
);
