

CREATE FUNCTION public.add_days(arg0 timestamp with time zone, arg1 anyelement DEFAULT 0) RETURNS timestamp with time zone
    LANGUAGE plpgsql
    AS $$begin
  return arg0+(coalesce(arg1,0)||' d')::interval;
end;$$;


--
-- TOC entry 335 (class 1255 OID 27115)
-- Name: add_days(timestamp with time zone, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.add_days(arg0 timestamp with time zone, arg1 text DEFAULT '0'::text) RETURNS timestamp with time zone
    LANGUAGE plpgsql
    AS $$begin
  return arg0+(coalesce(arg1,'0')||' d')::interval;
end;$$;


--
-- TOC entry 336 (class 1255 OID 27116)
-- Name: add_months(timestamp with time zone, anyelement); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.add_months(arg0 timestamp with time zone, arg1 anyelement DEFAULT 0) RETURNS timestamp with time zone
    LANGUAGE plpgsql
    AS $$begin
  return arg0+(coalesce(arg1,0)||' month')::interval;
end;$$;


--
-- TOC entry 337 (class 1255 OID 27117)
-- Name: add_months(timestamp with time zone, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.add_months(arg0 timestamp with time zone, arg1 text DEFAULT '0'::text) RETURNS timestamp with time zone
    LANGUAGE plpgsql
    AS $$begin
  return arg0+(coalesce(arg1,'0')||' month')::interval;
end;$$;


--
-- TOC entry 338 (class 1255 OID 27118)
-- Name: add_years(timestamp with time zone, anyelement); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.add_years(arg0 timestamp with time zone, arg1 anyelement DEFAULT 0) RETURNS timestamp with time zone
    LANGUAGE plpgsql
    AS $$begin
  return arg0+(coalesce(arg1,0)||' year')::interval;
end;$$;


--
-- TOC entry 339 (class 1255 OID 27119)
-- Name: add_years(timestamp with time zone, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.add_years(arg0 timestamp with time zone, arg1 text DEFAULT '0'::text) RETURNS timestamp with time zone
    LANGUAGE plpgsql
    AS $$begin
  return arg0+(coalesce(arg1,'0')||' year')::interval;
end;$$;


--
-- TOC entry 366 (class 1255 OID 27120)
-- Name: debug(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.debug(arg text) RETURNS void
    LANGUAGE plpgsql
    AS $$
begin
  raise notice '%', arg;
end;
$$;


--
-- TOC entry 340 (class 1255 OID 27121)
-- Name: decode(text[]); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.decode(VARIADIC p_decode_list text[]) RETURNS text
    LANGUAGE plpgsql
    AS $$begin 
return decode_internal(p_decode_list);
end;$$;


--
-- TOC entry 363 (class 1255 OID 27122)
-- Name: decode(anyarray); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.decode(VARIADIC p_decode_list anyarray) RETURNS text
    LANGUAGE plpgsql
    AS $$begin 
return decode_internal(p_decode_list);
end;$$;


--
-- TOC entry 364 (class 1255 OID 27123)
-- Name: decode(anyelement, anyelement, text, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.decode(arg0 anyelement, arg1 anyelement, result1 text, result2 text DEFAULT NULL::text) RETURNS text
    LANGUAGE plpgsql
    AS $$declare
begin
 --raise notice '4参数'; 
 return decode_internal(arg0,array[arg1],array[result1,result2]);
end;$$;


--
-- TOC entry 365 (class 1255 OID 27124)
-- Name: decode(bigint, bigint, boolean, boolean); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.decode(arg0 bigint, arg1 bigint, result1 boolean, result2 boolean DEFAULT NULL::boolean) RETURNS text
    LANGUAGE plpgsql
    AS $$declare
begin
  --raise notice '6参数';
 return decode_internal(arg0,array[arg1],array[result1,result2]);
end;$$;


--
-- TOC entry 341 (class 1255 OID 27125)
-- Name: decode(anyelement, anyelement, text, anyelement, text, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.decode(arg0 anyelement, arg1 anyelement, result1 text, arg2 anyelement, result2 text, result3 text DEFAULT NULL::text) RETURNS text
    LANGUAGE plpgsql
    AS $$declare
begin
 --raise notice '6参数';
 return decode_internal(arg0,array[arg1,arg2],array[result1,result2,result3]);
end;$$;


--
-- TOC entry 362 (class 1255 OID 27126)
-- Name: decode_internal(anyarray); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.decode_internal(p_decode_list anyarray) RETURNS text
    LANGUAGE plpgsql
    AS $$declare
 -- 获取数组长度(即入参个数)
 v_len integer := array_length(p_decode_list, 1);
 -- 声明存放返回值的变量
 v_ret text; 
 finded boolean:=false;
begin
raise notice '执行了 anyarray';
 /*
 * 功能说明:模拟Oracle中的DECODE功能(字符串处理, 其它格式可以自行转换返回值)
 * 参数说明:格式同Oracle相同,至少三个参数
 * 实现原理: 1、VARIADIC 允许变参; 2、Oracle中的DECODE是拿第一个数依次和之后的偶数位值进行比较,相同则取偶数位+1的数值,否则取最后一位值(最后一位为偶数为,否则为null)
 */
 
 -- 同Oracle相同当参数不足三个抛出异常
 if v_len >= 3 then
  -- Oracle中的DECODE是拿第一个数依次和之后的偶数位值进行比较,相同则取偶数位+1的数值
  for i in 2..(v_len - 1) loop
   v_ret := null;
   if mod(i, 2) = 0 then
    if p_decode_list[1] = p_decode_list[i] then
     v_ret := p_decode_list[i+1];
	 finded:=true;
    --增加对输入数据是null的支持
    elsif  p_decode_list[1] is null and p_decode_list[i] is null then 
	  v_ret := p_decode_list[i+1];
	  finded:=true;
    elsif v_len = i + 2 and v_len > 3 then
      v_ret := p_decode_list[v_len];
	  finded:=true;
    end if;
   end if;
   exit when v_ret is not null;
  end loop;
  if(v_ret is null and not finded) then
     v_ret:=p_decode_list[1];
  end if;
 else
  raise exception 'UPG-00938: not enough args for function.';
 end if;
 return v_ret;
end;$$;


--
-- TOC entry 359 (class 1255 OID 27127)
-- Name: decode_internal(anyelement, anyarray, boolean[]); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.decode_internal(arg0 anyelement, p_decode_list anyarray, result boolean[]) RETURNS text
    LANGUAGE plpgsql
    AS $$declare 
 -- 获取数组长度(即入参个数)
 v_len integer := array_length(p_decode_list, 1);
 v_len2 integer := array_length(result, 1);
 -- 声明存放返回值的变量
 v_ret bool;
 finded boolean;
begin
-- raise notice '执行了 anyelement,anyarray,text[]';
 /*
 * 功能说明:模拟Oracle中的DECODE功能(字符串处理, 其它格式可以自行转换返回值)
 * 参数说明:格式同Oracle相同,至少三个参数
 * 实现原理: 1、VARIADIC 允许变参; 2、Oracle中的DECODE是拿第一个数依次和之后的偶数位值进行比较,相同则取偶数位+1的数值,否则取最后一位值(最后一位为偶数为,否则为null)
 */
 if(v_len<1 and v_len2<1) then
   raise exception 'UPG-00938: not enough args for function.';
 end if;
 for i in 1..v_len loop
    if arg0 = p_decode_list[i] then
      v_ret := result[i];
	  finded:=true;
	--增加对输入数据是null的支持
    elsif  arg0 is null and p_decode_list[i] is null then 
	  v_ret := result[i];
	  finded:=true;
    elsif v_len=i and v_len = v_len2-1 then
      v_ret := result[v_len2];
	  finded:=true;
    end if;
   exit when v_ret is not null;
 end loop;
 if(v_ret is null and not finded) then
 	v_ret:=arg0;
 end if;
 return v_ret;
end;$$;


--
-- TOC entry 358 (class 1255 OID 27128)
-- Name: decode_internal(anyelement, anyarray, text[]); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.decode_internal(arg0 anyelement, p_decode_list anyarray, result text[]) RETURNS text
    LANGUAGE plpgsql
    AS $$declare
 -- 获取数组长度(即入参个数)
 v_len integer := array_length(p_decode_list, 1);
 v_len2 integer := array_length(result, 1);
 -- 声明存放返回值的变量
 v_ret text;
 finded boolean;
begin
-- raise notice '执行了 anyelement,anyarray,text[]';
 /*
 * 功能说明:模拟Oracle中的DECODE功能(字符串处理, 其它格式可以自行转换返回值)
 * 参数说明:格式同Oracle相同,至少三个参数
 * 实现原理: 1、VARIADIC 允许变参; 2、Oracle中的DECODE是拿第一个数依次和之后的偶数位值进行比较,相同则取偶数位+1的数值,否则取最后一位值(最后一位为偶数为,否则为null)
 */
 if(v_len<1 and v_len2<1) then
   raise exception 'UPG-00938: not enough args for function.';
 end if;
 for i in 1..v_len loop
    if arg0 = p_decode_list[i] then
      v_ret := result[i];
	  finded:=true;
	--增加对输入数据是null的支持
    elsif  arg0 is null and p_decode_list[i] is null then 
	  v_ret := result[i];
	  finded:=true;
    elsif v_len=i and v_len = v_len2-1 then
      v_ret := result[v_len2];
	  finded:=true;
    end if;
   exit when v_ret is not null;
 end loop;
 if(v_ret is null and not finded) then
 	v_ret:=arg0;
 end if;
 return v_ret;
end;$$;


--
-- TOC entry 354 (class 1255 OID 27129)
-- Name: to_char(integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.to_char(arg0 integer) RETURNS text
    LANGUAGE plpgsql
    AS $$begin 
  return to_char(arg0::text);
end;$$;


--
-- TOC entry 355 (class 1255 OID 27130)
-- Name: to_char(bigint); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.to_char(arg0 bigint) RETURNS text
    LANGUAGE plpgsql
    AS $$begin
  return to_char(arg0::text);
end; 
$$;


--
-- TOC entry 356 (class 1255 OID 27131)
-- Name: to_char(numeric); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.to_char(arg0 numeric) RETURNS text
    LANGUAGE plpgsql
    AS $$begin 
  return to_char(arg0::text);
end;$$;


--
-- TOC entry 357 (class 1255 OID 27132)
-- Name: to_char(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.to_char(arg0 text) RETURNS text
    LANGUAGE plpgsql
    AS $$begin
   return ''||arg0;
end;$$;


--
-- TOC entry 202 (class 1259 OID 27133)
-- Name: dual; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.dual WITH (security_barrier='false') AS
 SELECT NULL::text AS text;


