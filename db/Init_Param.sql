insert into T_PARAM_TYPE (F_ID,F_CODE, F_NAME)
values ( 1,'passwordStrategy', '密码策略');

insert into T_PARAM_INFO ( F_TYPE_ID, F_CODE, F_NAME, F_VALUE,  F_REMARK)
values ( 1, 'locktime', '登陆失败超过最大次数锁定时长', '5', '单位：分钟');

insert into T_PARAM_INFO ( F_TYPE_ID, F_CODE, F_NAME, F_VALUE,  F_REMARK)
values ( 1, 'maxloginfailedcount', '最大登陆失败次数', '5', '0：不限制失败次数，不锁定');

insert into T_PARAM_INFO ( F_TYPE_ID, F_CODE, F_NAME, F_VALUE,  F_REMARK)
values ( 1, 'needvalidtime', '是否需要验证密码有效期', '0',  '1：需要；0：不需要');

insert into T_PARAM_INFO ( F_TYPE_ID, F_CODE, F_NAME, F_VALUE,  F_REMARK)
values ( 1, 'validtimelength', '修改密码后默认有效期时长', '3', '单位：月');


