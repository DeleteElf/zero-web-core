/*==============================================================*/
/* DBMS name:      PostgreSQL 9.x                               */
/* Created on:     2026/11/18 16:50:22                          */
/*==============================================================*/


/*==============================================================*/
/* Table: T_MENU                                                */
/*==============================================================*/
CREATE TABLE T_MENU (
   F_ID                 SERIAL NOT NULL,
   F_PARENT_ID          INT8                 NOT NULL DEFAULT 0,
   F_NAME               VARCHAR(20)          NOT NULL,
   F_AUTHORIZE_CODE     VARCHAR(50)          NULL,
   F_ARGS               VARCHAR(100)         NULL,
   F_PATH               VARCHAR(1000)        NULL,
   F_ASSEMBLY           VARCHAR(200)         NULL,
   F_IMAGE_URL          VARCHAR(200)         NULL,
   F_SHORTCUT           VARCHAR(20)          NULL,
   F_CHECKED            BOOL                 NOT NULL DEFAULT FALSE,
   F_ENABLED            BOOL                 NOT NULL DEFAULT TRUE,
   F_VISIBLE            BOOL                 NOT NULL DEFAULT TRUE,
   F_SORT               INT2                 NOT NULL DEFAULT 0,
   F_ACTIVE             BOOL                 NOT NULL DEFAULT TRUE,
   F_CREATE_TIME        TIMESTAMP            NOT NULL DEFAULT CURRENT_TIMESTAMP,
   F_MODIFY_TIME        TIMESTAMP            NOT NULL DEFAULT CURRENT_TIMESTAMP,
   F_REMARK             TEXT                 NULL,
   CONSTRAINT PK_T_MENU PRIMARY KEY (F_ID)
);

COMMENT ON TABLE T_MENU IS
'菜单表';

COMMENT ON COLUMN T_MENU.F_ID IS
'编号';

COMMENT ON COLUMN T_MENU.F_PARENT_ID IS
'上级菜单';

COMMENT ON COLUMN T_MENU.F_NAME IS
'名称';

COMMENT ON COLUMN T_MENU.F_AUTHORIZE_CODE IS
'授权编码';

COMMENT ON COLUMN T_MENU.F_ARGS IS
'默认参数';

COMMENT ON COLUMN T_MENU.F_PATH IS
'地址';

COMMENT ON COLUMN T_MENU.F_ASSEMBLY IS
'程序集信息';

COMMENT ON COLUMN T_MENU.F_IMAGE_URL IS
'图标';

COMMENT ON COLUMN T_MENU.F_SHORTCUT IS
'热键';

COMMENT ON COLUMN T_MENU.F_CHECKED IS
'是否选中';

COMMENT ON COLUMN T_MENU.F_ENABLED IS
'是否可用';

COMMENT ON COLUMN T_MENU.F_VISIBLE IS
'是否可视';

COMMENT ON COLUMN T_MENU.F_SORT IS
'排序编号';

COMMENT ON COLUMN T_MENU.F_ACTIVE IS
'是否有效';

COMMENT ON COLUMN T_MENU.F_CREATE_TIME IS
'创建时间';

COMMENT ON COLUMN T_MENU.F_MODIFY_TIME IS
'修改时间';

COMMENT ON COLUMN T_MENU.F_REMARK IS
'备注';

/*==============================================================*/
/* Table: T_PARAM_INFO                                          */
/*==============================================================*/
CREATE TABLE T_PARAM_INFO (
   F_ID                 SERIAL NOT NULL,
   F_TYPE_ID            INT8                 NULL,
   F_CODE               VARCHAR(50)          NOT NULL,
   F_NAME               VARCHAR(50)          NOT NULL,
   F_VALUE              TEXT                 NULL,
   F_SORT               INT2                 NOT NULL DEFAULT 0,
   F_ACTIVE             BOOL                 NOT NULL DEFAULT TRUE,
   F_CREATE_TIME        TIMESTAMP            NOT NULL DEFAULT CURRENT_TIMESTAMP,
   F_MODIFY_TIME        TIMESTAMP            NOT NULL DEFAULT CURRENT_TIMESTAMP,
   F_REMARK             TEXT                 NULL,
   CONSTRAINT PK_T_PARAM_INFO PRIMARY KEY (F_ID)
);

COMMENT ON TABLE T_PARAM_INFO IS
'系统参数表';

COMMENT ON COLUMN T_PARAM_INFO.F_ID IS
'编号';

COMMENT ON COLUMN T_PARAM_INFO.F_TYPE_ID IS
'类型编号';

COMMENT ON COLUMN T_PARAM_INFO.F_CODE IS
'编码';

COMMENT ON COLUMN T_PARAM_INFO.F_NAME IS
'名称';

COMMENT ON COLUMN T_PARAM_INFO.F_VALUE IS
'值';

COMMENT ON COLUMN T_PARAM_INFO.F_SORT IS
'排序编号';

COMMENT ON COLUMN T_PARAM_INFO.F_ACTIVE IS
'是否有效';

COMMENT ON COLUMN T_PARAM_INFO.F_CREATE_TIME IS
'创建时间';

COMMENT ON COLUMN T_PARAM_INFO.F_MODIFY_TIME IS
'修改时间';

COMMENT ON COLUMN T_PARAM_INFO.F_REMARK IS
'备注';

/*==============================================================*/
/* Index: U_PARAM_INFO                                          */
/*==============================================================*/
CREATE UNIQUE INDEX U_PARAM_INFO ON T_PARAM_INFO (
F_CODE
);

/*==============================================================*/
/* Table: T_PARAM_TYPE                                          */
/*==============================================================*/
CREATE TABLE T_PARAM_TYPE (
   F_ID                 SERIAL NOT NULL,
   F_CODE               VARCHAR(50)          NOT NULL,
   F_NAME               VARCHAR(50)          NOT NULL,
   F_SORT               INT2                 NOT NULL DEFAULT 0,
   F_ACTIVE             BOOL                 NOT NULL DEFAULT TRUE,
   F_CREATE_TIME        TIMESTAMP            NOT NULL DEFAULT CURRENT_TIMESTAMP,
   F_MODIFY_TIME        TIMESTAMP            NOT NULL DEFAULT CURRENT_TIMESTAMP,
   F_REMARK             TEXT                 NULL,
   CONSTRAINT PK_T_PARAM_TYPE PRIMARY KEY (F_ID)
);

COMMENT ON TABLE T_PARAM_TYPE IS
'系统参数类型表';

COMMENT ON COLUMN T_PARAM_TYPE.F_ID IS
'编号';

COMMENT ON COLUMN T_PARAM_TYPE.F_CODE IS
'类型编码';

COMMENT ON COLUMN T_PARAM_TYPE.F_NAME IS
'名称';

COMMENT ON COLUMN T_PARAM_TYPE.F_SORT IS
'排序编号';

COMMENT ON COLUMN T_PARAM_TYPE.F_ACTIVE IS
'是否有效';

COMMENT ON COLUMN T_PARAM_TYPE.F_CREATE_TIME IS
'创建时间';

COMMENT ON COLUMN T_PARAM_TYPE.F_MODIFY_TIME IS
'修改时间';

COMMENT ON COLUMN T_PARAM_TYPE.F_REMARK IS
'备注';

/*==============================================================*/
/* Index: U_PARAM_TYPE                                          */
/*==============================================================*/
CREATE UNIQUE INDEX U_PARAM_TYPE ON T_PARAM_TYPE (
F_CODE
);

/*==============================================================*/
/* Table: T_TOOLBAR                                             */
/*==============================================================*/
CREATE TABLE T_TOOLBAR (
   F_ID                 SERIAL NOT NULL,
   F_NAME               VARCHAR(20)          NOT NULL,
   F_MENU_NAME          VARCHAR(20)          NULL,
   F_TOOLTIP_TEXT       VARCHAR(256)         NULL,
   F_IMAGE              VARCHAR(256)         NULL,
   F_SORT               INT2                 NOT NULL DEFAULT 0,
   F_ACTIVE             BOOL                 NOT NULL DEFAULT TRUE,
   F_CREATE_TIME        TIMESTAMP            NOT NULL DEFAULT CURRENT_TIMESTAMP,
   F_MODIFY_TIME        TIMESTAMP            NOT NULL DEFAULT CURRENT_TIMESTAMP,
   F_REMARK             TEXT                 NULL,
   CONSTRAINT PK_T_TOOLBAR PRIMARY KEY (F_ID)
);

COMMENT ON TABLE T_TOOLBAR IS
'工具栏';

COMMENT ON COLUMN T_TOOLBAR.F_ID IS
'编号';

COMMENT ON COLUMN T_TOOLBAR.F_NAME IS
'名称';

COMMENT ON COLUMN T_TOOLBAR.F_MENU_NAME IS
'菜单名称';

COMMENT ON COLUMN T_TOOLBAR.F_TOOLTIP_TEXT IS
'描述信息';

COMMENT ON COLUMN T_TOOLBAR.F_IMAGE IS
'图片位置';

COMMENT ON COLUMN T_TOOLBAR.F_SORT IS
'排序编号';

COMMENT ON COLUMN T_TOOLBAR.F_ACTIVE IS
'是否有效';

COMMENT ON COLUMN T_TOOLBAR.F_CREATE_TIME IS
'创建时间';

COMMENT ON COLUMN T_TOOLBAR.F_MODIFY_TIME IS
'修改时间';

COMMENT ON COLUMN T_TOOLBAR.F_REMARK IS
'备注';

/*==============================================================*/
/* Index: I_TOOLBAR_NAME                                        */
/*==============================================================*/
CREATE UNIQUE INDEX I_TOOLBAR_NAME ON T_TOOLBAR (
F_NAME
);

