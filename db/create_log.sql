/*==============================================================*/
/* DBMS name:      PostgreSQL 9.x                               */
/* Created on:     2026/11/18 16:31:09                          */
/*==============================================================*/


DROP TABLE T_DA_LOG;

DROP TABLE T_PROCESS_RECORD;

DROP TABLE T_SYNC_LIST;

DROP TABLE T_SYNC_RECORD;

DROP TABLE T_WEBSERVICE_LOG;

DROP TABLE T_LOG;

DROP TABLE T_TOOL_LOG;

/*==============================================================*/
/* Table: T_DA_LOG                                              */
/*==============================================================*/
CREATE TABLE T_DA_LOG (
   F_ID                 SERIAL NOT NULL,
   F_GROUP_NAME         VARCHAR(50)          NULL,
   F_CONFIG_ID          INT4                 NULL,
   F_SETTING_NAME       VARCHAR(50)          NULL,
   F_CONTENT            TEXT                 NULL,
   F_RESULT             VARCHAR(10)          NOT NULL,
   F_START_TIME         TIMESTAMP            NULL,
   F_SEARCHTIME         TIMESTAMP            NULL,
   F_UPDATETIME         TIMESTAMP            NULL,
   F_SORT               INT2                 NOT NULL DEFAULT 0,
   F_ACTIVE             BOOL                 NOT NULL DEFAULT TRUE,
   F_CREATE_TIME        TIMESTAMP            NOT NULL DEFAULT CURRENT_TIMESTAMP,
   F_MODIFY_TIME        TIMESTAMP            NOT NULL DEFAULT CURRENT_TIMESTAMP,
   F_REMARK             TEXT                 NULL,
   CONSTRAINT PK_T_DA_LOG PRIMARY KEY (F_ID)
);

COMMENT ON TABLE T_DA_LOG IS
'数据采集日志表';

COMMENT ON COLUMN T_DA_LOG.F_ID IS
'编号';

COMMENT ON COLUMN T_DA_LOG.F_GROUP_NAME IS
'分组名称';

COMMENT ON COLUMN T_DA_LOG.F_CONFIG_ID IS
'配置ID';

COMMENT ON COLUMN T_DA_LOG.F_SETTING_NAME IS
'配置名称';

COMMENT ON COLUMN T_DA_LOG.F_CONTENT IS
'执行内容';

COMMENT ON COLUMN T_DA_LOG.F_RESULT IS
'执行结果';

COMMENT ON COLUMN T_DA_LOG.F_START_TIME IS
'开始执行时间';

COMMENT ON COLUMN T_DA_LOG.F_SEARCHTIME IS
'完成查询时间';

COMMENT ON COLUMN T_DA_LOG.F_UPDATETIME IS
'完成插入时间';

COMMENT ON COLUMN T_DA_LOG.F_SORT IS
'排序编号';

COMMENT ON COLUMN T_DA_LOG.F_ACTIVE IS
'是否有效';

COMMENT ON COLUMN T_DA_LOG.F_CREATE_TIME IS
'创建时间';

COMMENT ON COLUMN T_DA_LOG.F_MODIFY_TIME IS
'修改时间';

COMMENT ON COLUMN T_DA_LOG.F_REMARK IS
'备注';

/*==============================================================*/
/* Table: T_PROCESS_RECORD                                      */
/*==============================================================*/
CREATE TABLE T_PROCESS_RECORD (
   F_ID                 SERIAL NOT NULL,
   F_INFO_TABLE_NAME    VARCHAR(30)          NULL,
   F_INFO_ID            INT8                 NOT NULL,
   F_PROCESS_ID         INT8                 NOT NULL,
   F_PROCESS_STEP_ID    INT8                 NOT NULL,
   F_OPERATING          VARCHAR(10)          NOT NULL,
   F_USER_ID            INT8                 NOT NULL,
   F_USER_NAME          VARCHAR(20)          NOT NULL,
   F_SORT               INT2                 NOT NULL DEFAULT 0,
   F_ACTIVE             BOOL                 NOT NULL DEFAULT TRUE,
   F_CREATE_TIME        TIMESTAMP            NOT NULL DEFAULT CURRENT_TIMESTAMP,
   F_MODIFY_TIME        TIMESTAMP            NOT NULL DEFAULT CURRENT_TIMESTAMP,
   F_REMARK             TEXT                 NULL,
   CONSTRAINT PK_T_PROCESS_RECORD PRIMARY KEY (F_ID)
);

COMMENT ON TABLE T_PROCESS_RECORD IS
'流程操作记录';

COMMENT ON COLUMN T_PROCESS_RECORD.F_ID IS
'编号';

COMMENT ON COLUMN T_PROCESS_RECORD.F_INFO_TABLE_NAME IS
'信息表名';

COMMENT ON COLUMN T_PROCESS_RECORD.F_INFO_ID IS
'信息编号';

COMMENT ON COLUMN T_PROCESS_RECORD.F_PROCESS_ID IS
'流程编号';

COMMENT ON COLUMN T_PROCESS_RECORD.F_PROCESS_STEP_ID IS
'流程步骤关系编号';

COMMENT ON COLUMN T_PROCESS_RECORD.F_OPERATING IS
'操作';

COMMENT ON COLUMN T_PROCESS_RECORD.F_USER_ID IS
'操作者编号';

COMMENT ON COLUMN T_PROCESS_RECORD.F_USER_NAME IS
'操作者';

COMMENT ON COLUMN T_PROCESS_RECORD.F_SORT IS
'排序编号';

COMMENT ON COLUMN T_PROCESS_RECORD.F_ACTIVE IS
'是否有效';

COMMENT ON COLUMN T_PROCESS_RECORD.F_CREATE_TIME IS
'创建时间';

COMMENT ON COLUMN T_PROCESS_RECORD.F_MODIFY_TIME IS
'修改时间';

COMMENT ON COLUMN T_PROCESS_RECORD.F_REMARK IS
'备注';

/*==============================================================*/
/* Table: T_SYNC_LIST                                           */
/*==============================================================*/
CREATE TABLE T_SYNC_LIST (
   F_ID                 SERIAL NOT NULL,
   F_TABLE_NAME         VARCHAR(30)          NOT NULL,
   F_PKEY               VARCHAR(10)          NULL DEFAULT 'f_id',
   F_WITHOUT_COMPANY    BOOL                 NOT NULL DEFAULT TRUE,
   F_SORT               INT2                 NOT NULL DEFAULT 0,
   F_ACTIVE             BOOL                 NOT NULL DEFAULT TRUE,
   F_CREATE_TIME        TIMESTAMP            NOT NULL DEFAULT CURRENT_TIMESTAMP,
   F_MODIFY_TIME        TIMESTAMP            NOT NULL DEFAULT CURRENT_TIMESTAMP,
   F_REMARK             TEXT                 NULL,
   CONSTRAINT PK_T_SYNC_LIST PRIMARY KEY (F_ID)
);

COMMENT ON TABLE T_SYNC_LIST IS
'系统同步清单表';

COMMENT ON COLUMN T_SYNC_LIST.F_ID IS
'编号';

COMMENT ON COLUMN T_SYNC_LIST.F_TABLE_NAME IS
'表名';

COMMENT ON COLUMN T_SYNC_LIST.F_PKEY IS
'主键';

COMMENT ON COLUMN T_SYNC_LIST.F_WITHOUT_COMPANY IS
'是否不是公司数据';

COMMENT ON COLUMN T_SYNC_LIST.F_SORT IS
'排序编号';

COMMENT ON COLUMN T_SYNC_LIST.F_ACTIVE IS
'是否有效';

COMMENT ON COLUMN T_SYNC_LIST.F_CREATE_TIME IS
'创建时间';

COMMENT ON COLUMN T_SYNC_LIST.F_MODIFY_TIME IS
'修改时间';

COMMENT ON COLUMN T_SYNC_LIST.F_REMARK IS
'备注';

/*==============================================================*/
/* Table: T_SYNC_RECORD                                         */
/*==============================================================*/
CREATE TABLE T_SYNC_RECORD (
   F_ID                 SERIAL NOT NULL,
   F_CONFIG_ID          INT8                 NOT NULL,
   F_COMPANY_ID         INT8                 NOT NULL,
   F_SYNC_TIME          TIMESTAMP            NOT NULL DEFAULT CURRENT_TIMESTAMP,
   F_SORT               INT2                 NOT NULL DEFAULT 0,
   F_ACTIVE             BOOL                 NOT NULL DEFAULT TRUE,
   F_CREATE_TIME        TIMESTAMP            NOT NULL DEFAULT CURRENT_TIMESTAMP,
   F_MODIFY_TIME        TIMESTAMP            NOT NULL DEFAULT CURRENT_TIMESTAMP,
   F_REMARK             TEXT                 NULL,
   CONSTRAINT PK_T_SYNC_RECORD PRIMARY KEY (F_ID)
);

COMMENT ON TABLE T_SYNC_RECORD IS
'系统同步记录表';

COMMENT ON COLUMN T_SYNC_RECORD.F_ID IS
'编号';

COMMENT ON COLUMN T_SYNC_RECORD.F_CONFIG_ID IS
'数据配置编号';

COMMENT ON COLUMN T_SYNC_RECORD.F_COMPANY_ID IS
'所属公司';

COMMENT ON COLUMN T_SYNC_RECORD.F_SYNC_TIME IS
'最后同步时间';

COMMENT ON COLUMN T_SYNC_RECORD.F_SORT IS
'排序编号';

COMMENT ON COLUMN T_SYNC_RECORD.F_ACTIVE IS
'是否有效';

COMMENT ON COLUMN T_SYNC_RECORD.F_CREATE_TIME IS
'创建时间';

COMMENT ON COLUMN T_SYNC_RECORD.F_MODIFY_TIME IS
'修改时间';

COMMENT ON COLUMN T_SYNC_RECORD.F_REMARK IS
'备注';

/*==============================================================*/
/* Table: T_WEBSERVICE_LOG                                      */
/*==============================================================*/
CREATE TABLE T_WEBSERVICE_LOG (
   F_ID                 SERIAL NOT NULL,
   F_ADDRESS            VARCHAR(200)         NOT NULL,
   F_SER_NAME           VARCHAR(50)          NOT NULL,
   F_RESULT             VARCHAR(20)          NOT NULL,
   F_REQUEST_CONTENT    TEXT                 NOT NULL,
   F_RESPONSE_CONTENT   TEXT                 NOT NULL,
   F_SORT               INT2                 NOT NULL DEFAULT 0,
   F_ACTIVE             BOOL                 NOT NULL DEFAULT TRUE,
   F_CREATE_TIME        TIMESTAMP            NOT NULL DEFAULT CURRENT_TIMESTAMP,
   F_MODIFY_TIME        TIMESTAMP            NOT NULL DEFAULT CURRENT_TIMESTAMP,
   F_REMARK             TEXT                 NULL,
   CONSTRAINT PK_T_WEBSERVICE_LOG PRIMARY KEY (F_ID)
);

COMMENT ON TABLE T_WEBSERVICE_LOG IS
'系统服务接口日志表';

COMMENT ON COLUMN T_WEBSERVICE_LOG.F_ID IS
'编号';

COMMENT ON COLUMN T_WEBSERVICE_LOG.F_ADDRESS IS
'服务地址';

COMMENT ON COLUMN T_WEBSERVICE_LOG.F_SER_NAME IS
'服务名称';

COMMENT ON COLUMN T_WEBSERVICE_LOG.F_RESULT IS
'执行状态';

COMMENT ON COLUMN T_WEBSERVICE_LOG.F_REQUEST_CONTENT IS
'请求内容';

COMMENT ON COLUMN T_WEBSERVICE_LOG.F_RESPONSE_CONTENT IS
'应答内容';

COMMENT ON COLUMN T_WEBSERVICE_LOG.F_SORT IS
'排序编号';

COMMENT ON COLUMN T_WEBSERVICE_LOG.F_ACTIVE IS
'是否有效';

COMMENT ON COLUMN T_WEBSERVICE_LOG.F_CREATE_TIME IS
'创建时间';

COMMENT ON COLUMN T_WEBSERVICE_LOG.F_MODIFY_TIME IS
'修改时间';

COMMENT ON COLUMN T_WEBSERVICE_LOG.F_REMARK IS
'备注';

/*==============================================================*/
/* Table: T_LOG                                                 */
/*==============================================================*/
CREATE TABLE T_LOG (
   F_ID                 SERIAL NOT NULL,
   F_USER               VARCHAR(20)          NOT NULL,
   F_CATEGORY_NAME      VARCHAR(50)          NOT NULL,
   F_CONTENT            TEXT                 NOT NULL,
   F_LEVEL              VARCHAR(20)          NOT NULL,
   F_FROM               VARCHAR(300)         NOT NULL,
   F_SORT               INT2                 NOT NULL DEFAULT 0,
   F_ACTIVE             BOOL                 NOT NULL DEFAULT TRUE,
   F_CREATE_TIME        TIMESTAMP            NOT NULL DEFAULT CURRENT_TIMESTAMP,
   F_MODIFY_TIME        TIMESTAMP            NOT NULL DEFAULT CURRENT_TIMESTAMP,
   F_REMARK             TEXT                 NULL,
   CONSTRAINT PK_T_LOG PRIMARY KEY (F_ID)
);

COMMENT ON TABLE T_LOG IS
'系统日志表';

COMMENT ON COLUMN T_LOG.F_ID IS
'编号';

COMMENT ON COLUMN T_LOG.F_USER IS
'操作用户';

COMMENT ON COLUMN T_LOG.F_CATEGORY_NAME IS
'模块名称';

COMMENT ON COLUMN T_LOG.F_CONTENT IS
'操作内容';

COMMENT ON COLUMN T_LOG.F_LEVEL IS
'日志级别';

COMMENT ON COLUMN T_LOG.F_FROM IS
'来源';

COMMENT ON COLUMN T_LOG.F_SORT IS
'排序编号';

COMMENT ON COLUMN T_LOG.F_ACTIVE IS
'是否有效';

COMMENT ON COLUMN T_LOG.F_CREATE_TIME IS
'创建时间';

COMMENT ON COLUMN T_LOG.F_MODIFY_TIME IS
'修改时间';

COMMENT ON COLUMN T_LOG.F_REMARK IS
'备注';

/*==============================================================*/
/* Table: T_TOOL_LOG                                            */
/*==============================================================*/
CREATE TABLE T_TOOL_LOG (
   F_ID                 SERIAL NOT NULL,
   F_USER_IP            VARCHAR(40)          NOT NULL,
   F_MODEL              VARCHAR(50)          NOT NULL,
   F_CONTENT            TEXT                 NOT NULL,
   F_CONTENT_OLD        TEXT                 NOT NULL,
   F_ITEM_ID            INT8                 NOT NULL DEFAULT 0,
   F_ITEM_NAME          VARCHAR(50)          NOT NULL,
   F_ITEM_PATH          VARCHAR(50)          NOT NULL DEFAULT '1',
   F_SORT               INT2                 NOT NULL DEFAULT 0,
   F_ACTIVE             BOOL                 NOT NULL DEFAULT TRUE,
   F_CREATE_TIME        TIMESTAMP            NOT NULL DEFAULT CURRENT_TIMESTAMP,
   F_MODIFY_TIME        TIMESTAMP            NOT NULL DEFAULT CURRENT_TIMESTAMP,
   F_REMARK             TEXT                 NULL,
   CONSTRAINT PK_T_TOOL_LOG PRIMARY KEY (F_ID)
);

COMMENT ON TABLE T_TOOL_LOG IS
'工具日志表';

COMMENT ON COLUMN T_TOOL_LOG.F_ID IS
'编号';

COMMENT ON COLUMN T_TOOL_LOG.F_USER_IP IS
'用户IP';

COMMENT ON COLUMN T_TOOL_LOG.F_MODEL IS
'模块名称';

COMMENT ON COLUMN T_TOOL_LOG.F_CONTENT IS
'修改后';

COMMENT ON COLUMN T_TOOL_LOG.F_CONTENT_OLD IS
'修改前';

COMMENT ON COLUMN T_TOOL_LOG.F_ITEM_ID IS
'项目编号';

COMMENT ON COLUMN T_TOOL_LOG.F_ITEM_NAME IS
'项目名称';

COMMENT ON COLUMN T_TOOL_LOG.F_ITEM_PATH IS
'项目路径';

COMMENT ON COLUMN T_TOOL_LOG.F_SORT IS
'排序编号';

COMMENT ON COLUMN T_TOOL_LOG.F_ACTIVE IS
'是否有效';

COMMENT ON COLUMN T_TOOL_LOG.F_CREATE_TIME IS
'创建时间';

COMMENT ON COLUMN T_TOOL_LOG.F_MODIFY_TIME IS
'修改时间';

COMMENT ON COLUMN T_TOOL_LOG.F_REMARK IS
'备注';

