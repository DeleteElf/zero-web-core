CREATE OR REPLACE FUNCTION config.p_clone_da_config(IN id integer)
    RETURNS integer
    LANGUAGE 'plpgsql'
    VOLATILE
    PARALLEL UNSAFE
    COST 100

    SET search_path=config
AS $BODY$
declare newid integer;
begin
    --获取下个序列  获取序列必须带上scheme.
    --设置当前函数的scheme搜索路径
    --其他可以通过上面的set search_path='config' 解决，或者在函数内部增加这一句来设置该函数的全局支持
    --如果需要支持多个 则 set search_path='config,public'
    --如果需要支持当前用户，则set search_path='"$user",config,public'
    select nextval('config.t_da_config_f_id_seq') into newid;
    --克隆主表
    insert into t_da_config (f_id,f_group_id,f_start_time,f_name,f_source,f_datasource_type,f_collection_mode,f_batch_count,f_source_worker,
                             f_source_sql,f_tag_sql,f_target,f_target_before,f_target_sql,f_target_after,f_retry_count,
                             f_is_last_data,f_is_sort_memo,f_is_utc,f_active,f_remark)
    select newid,f_group_id,f_start_time,f_name||'_clone',f_source,f_datasource_type,f_collection_mode,f_batch_count,f_source_worker,
           f_source_sql,f_tag_sql,f_target,f_target_before,f_target_sql,f_target_after,f_retry_count,
           f_is_last_data,f_is_sort_memo,f_is_utc,false,f_remark
    from t_da_config
    where f_id=id;

    --克隆映射
    insert into t_da_mapping (f_config_id,f_code,f_rule,f_type,f_remark)
    select newid,f_code,f_rule,f_type,f_remark
    from t_da_mapping
    where f_config_id=id and f_active=true
    order by f_sort,f_id;

    return 1;
end;
$BODY$;


CREATE OR REPLACE FUNCTION config.p_clone_form_config(IN id integer)
    RETURNS integer
    LANGUAGE 'plpgsql'
    VOLATILE
    PARALLEL UNSAFE
    COST 100

    SET search_path=config
AS $BODY$
declare newid integer;
begin
    --获取下个序列   获取序列必须带上scheme.
    --设置当前函数的scheme搜索路径
    --其他可以通过上面的set search_path='config' 解决，或者在函数内部增加这一句来设置该函数的全局支持
    --如果需要支持多个 则 set search_path='config,public'
    --如果需要支持当前用户，则set search_path='"$user",config,public'
    select nextval('config.t_form_config_f_id_seq') into newid;
    --克隆主表
    insert into t_form_config (f_id,f_group_id,f_name,f_service,f_code,f_pk_column,
                               f_add_right,f_mod_right,f_del_right,f_log_module,f_log_message,
                               f_script_string,f_remark)
    select newid,f_group_id,f_name||'_clone',f_service,f_code,f_pk_column,
           f_add_right,f_mod_right,f_del_right,f_log_module,f_log_message,
           f_script_string,f_remark
    from t_form_config
    where f_id=id;

    --克隆表单项
    insert into t_form_item (f_form_id,f_name,f_code,f_type,f_column_count,f_datasource,
                             f_search_sql,f_linkage_rule,f_default_value,f_boolean_text,
                             f_is_empty,f_is_visible,f_vilidate_regex,f_format_string,
                             f_default_value_datasource,f_default_value_sql,f_js_change,
                             f_add_readonly,f_mod_readonly,f_message,f_unit,f_style,f_url,
                             f_remark)
    select newid,f_name,f_code,f_type,f_column_count,f_datasource,
           f_search_sql,f_linkage_rule,f_default_value,f_boolean_text,
           f_is_empty,f_is_visible,f_vilidate_regex,f_format_string,
           f_default_value_datasource,f_default_value_sql,f_js_change,
           f_add_readonly,f_mod_readonly,f_message,f_unit,f_style,f_url,
           f_remark
    from t_form_item
    where f_form_id=id and f_active=true
    order by f_sort,f_id;
    --克隆工具栏
    insert into t_form_toolbar_item (f_form_id,f_position,f_code,f_name,f_codition_template,
                                    f_style,f_handle_right,f_action_url,f_linkage_rule,
                                    f_format_string,f_type,f_script_string,f_remark)
    select newid,f_position,f_code,f_name,f_codition_template,
           f_style,f_handle_right,f_action_url,f_linkage_rule,
           f_format_string,f_type,f_script_string,f_remark
    from t_form_toolbar_item
    where f_form_id=id and f_active=true
    order by f_sort,f_id;
    return 1;
end;
$BODY$;

CREATE OR REPLACE FUNCTION config.p_clone_form_item(IN id integer)
    RETURNS integer
    LANGUAGE 'plpgsql'
    VOLATILE
    PARALLEL UNSAFE
    COST 100

    SET search_path=config
AS $BODY$
begin
    insert into t_form_item (f_form_id,f_name,f_code,f_type,f_column_count,f_datasource,
                             f_search_sql,f_linkage_rule,f_default_value,f_boolean_text,
                             f_is_empty,f_is_visible,f_validate_regex,f_format_string,
                             f_default_value_datasource,f_default_value_sql,f_js_change,
                             f_add_readonly,f_mod_readonly,f_message,f_unit,f_style,f_url,
                             f_remark)
    select f_form_id,f_name||'_clone',f_code,f_type,f_column_count,f_datasource,
           f_search_sql,f_linkage_rule,f_default_value,f_boolean_text,
           f_is_empty,f_is_visible,f_validate_regex,f_format_string,
           f_default_value_datasource,f_default_value_sql,f_js_change,
           f_add_readonly,f_mod_readonly,f_message,f_unit,f_style,f_url,
           f_remark
    from t_form_item
    where f_id=id;
    return 1;
end;
$BODY$;



CREATE OR REPLACE FUNCTION config.p_clone_form_toolbar_item(IN id integer)
    RETURNS integer
    LANGUAGE 'plpgsql'
    VOLATILE
    PARALLEL UNSAFE
    COST 100

    SET search_path=config
AS $BODY$
begin
    insert into t_form_toolbar_item (f_form_id,f_position,f_code,f_name,f_condition_template,
                                    f_style,f_handle_right,f_action_url,f_linkage_rule,
                                    f_format_string,f_type,f_script_string,f_remark)
    select f_form_id,f_position,f_code,f_name||'_clone',f_condition_template,
           f_style,f_handle_right,f_action_url,f_linkage_rule,
           f_format_string,f_type,f_script_string,f_remark
    from t_form_toolbar_item
    where f_id=id;
    return 1;
end;
$BODY$;


CREATE OR REPLACE FUNCTION config.p_clone_json_config(IN id integer)
    RETURNS integer
    LANGUAGE 'plpgsql'
    VOLATILE
    PARALLEL UNSAFE
    COST 100

    SET search_path=config
AS $BODY$
begin
    insert into t_json_item (f_group_id,f_name,f_handle_right,f_enable_trans,
                             f_datasource,f_before,f_command_text,f_after,f_remark)
    select f_group_id,f_name||'_clone',f_handle_right,f_enable_trans,
           f_datasource,f_before,f_command_text,f_after,f_remark
    from t_json_item
    where f_id=id;
    return 1;
end;
$BODY$;


CREATE OR REPLACE FUNCTION config.p_clone_json_tree_config(IN id integer)
    RETURNS integer
    LANGUAGE 'plpgsql'
    VOLATILE
    PARALLEL UNSAFE
    COST 100

    SET search_path=config
AS $BODY$
begin
    insert into t_json_tree_data (f_group_id,f_name,f_table_name,f_condition,
                                  f_datasource,f_recursive_table_name,f_recursive_condition,f_command_text,f_remark)
    select f_group_id,f_name||'_clone',f_table_name,f_condition,
           f_datasource,f_recursive_table_name,f_recursive_condition,f_command_text,f_remark
    from t_json_tree_data
    where f_id=id;
    return 1;
end;
$BODY$;


CREATE OR REPLACE FUNCTION config.p_clone_report_config(IN id integer)
    RETURNS integer
    LANGUAGE 'plpgsql'
    VOLATILE
    PARALLEL UNSAFE
    COST 100

    SET search_path=config
AS $BODY$
declare newid integer;
begin
    --获取下个序列   获取序列必须带上scheme.
    --设置当前函数的scheme搜索路径
    --其他可以通过上面的set search_path='config' 解决，或者在函数内部增加这一句来设置该函数的全局支持
    --如果需要支持多个 则 set search_path='config,public'
    --如果需要支持当前用户，则set search_path='"$user",config,public'
    select nextval('config.t_report_item_f_id_seq') into newid;
    --克隆主表
    insert into t_report_item (f_id,f_group_id,f_name,f_template,f_remark)
    select newid,f_group_id,f_name||'_clone',f_template,f_remark
    from t_report_item
    where f_id=id;

    --克隆映射
    insert into t_report_table (f_report_id,f_name,f_datasource_name,f_command_text,f_remark)
    select newid,f_name,f_datasource_name,f_command_text,f_remark
    from t_report_table
    where f_report_id=id and f_active=true
    order by f_sort,f_id;
    return 1;
end;
$BODY$;