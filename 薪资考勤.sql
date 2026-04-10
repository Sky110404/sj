CREATE DATABASE IF NOT EXISTS attendance_salary_system DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE attendance_salary_system;


CREATE DATABASE IF NOT EXISTS attendance_salary_system DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE attendance_salary_system;

-- 1.字典类型表
DROP TABLE IF EXISTS sys_dict_type;
CREATE TABLE sys_dict_type (
    id BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    type_code VARCHAR(32) NOT NULL COMMENT '字典类型编码',
    type_name VARCHAR(64) NOT NULL COMMENT '字典类型名称',
    sort INT DEFAULT 0 COMMENT '排序',
    remark VARCHAR(255) DEFAULT '' COMMENT '备注',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    is_deleted TINYINT DEFAULT 0 COMMENT '是否删除 0未删除 1已删除',
    PRIMARY KEY (id),
    UNIQUE KEY uk_type_code (type_code)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='字典类型表';

-- 2.字典数据表
DROP TABLE IF EXISTS sys_dict_data;
CREATE TABLE sys_dict_data (
    id BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    type_code VARCHAR(32) NOT NULL COMMENT '字典类型编码',
    dict_label VARCHAR(64) NOT NULL COMMENT '字典标签',
    dict_value VARCHAR(64) NOT NULL COMMENT '字典值',
    sort INT DEFAULT 0 COMMENT '排序',
    status TINYINT DEFAULT 1 COMMENT '状态 0禁用 1启用',
    remark VARCHAR(255) DEFAULT '' COMMENT '备注',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    is_deleted TINYINT DEFAULT 0 COMMENT '是否删除 0未删除 1已删除',
    PRIMARY KEY (id),
    KEY idx_type_code (type_code)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='字典数据表';

-- 3.系统参数配置表
DROP TABLE IF EXISTS sys_config;
CREATE TABLE sys_config (
    id BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    config_key VARCHAR(64) NOT NULL COMMENT '配置键',
    config_value VARCHAR(500) NOT NULL COMMENT '配置值',
    config_name VARCHAR(100) DEFAULT '' COMMENT '配置名称',
    remark VARCHAR(255) DEFAULT '' COMMENT '备注',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    is_deleted TINYINT DEFAULT 0 COMMENT '是否删除 0未删除 1已删除',
    PRIMARY KEY (id),
    UNIQUE KEY uk_config_key (config_key)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='系统参数配置表';

-- 4.节假日配置表
DROP TABLE IF EXISTS sys_holiday;
CREATE TABLE sys_holiday (
    id BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    holiday_date DATE NOT NULL COMMENT '节假日日期',
    holiday_name VARCHAR(64) DEFAULT '' COMMENT '节日名称',
    holiday_type TINYINT DEFAULT 1 COMMENT '1法定 2公司假日 3调班',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    is_deleted TINYINT DEFAULT 0 COMMENT '是否删除 0未删除 1已删除',
    PRIMARY KEY (id),
    UNIQUE KEY uk_holiday_date (holiday_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='节假日配置表';

-- 5.班次表
DROP TABLE IF EXISTS attend_shift;
CREATE TABLE attend_shift (
    id BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    shift_name VARCHAR(32) NOT NULL COMMENT '班次名称',
    start_time TIME NOT NULL COMMENT '上班时间',
    end_time TIME NOT NULL COMMENT '下班时间',
    check_in_start TIME COMMENT '签到开始时间',
    check_in_end TIME COMMENT '签到结束时间',
    check_out_start TIME COMMENT '签退开始时间',
    check_out_end TIME COMMENT '签退结束时间',
    work_hours DECIMAL(4,2) DEFAULT 0.00 COMMENT '应出勤工时',
    status TINYINT DEFAULT 1 COMMENT '状态 0禁用 1启用',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    is_deleted TINYINT DEFAULT 0 COMMENT '是否删除 0未删除 1已删除',
    PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='班次表';

-- 6.公司信息表
DROP TABLE IF EXISTS company_info;
CREATE TABLE company_info (
    id BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    company_name VARCHAR(100) NOT NULL COMMENT '公司名称',
    address VARCHAR(255) DEFAULT '' COMMENT '公司地址',
    contact_phone VARCHAR(20) DEFAULT '' COMMENT '联系电话',
    legal_person VARCHAR(32) DEFAULT '' COMMENT '法人',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    is_deleted TINYINT DEFAULT 0 COMMENT '是否删除 0未删除 1已删除',
    PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='公司信息表';

-- 7.部门表
DROP TABLE IF EXISTS department;
CREATE TABLE department (
    id BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    dept_name VARCHAR(64) NOT NULL COMMENT '部门名称',
    parent_id BIGINT DEFAULT 0 COMMENT '上级部门ID',
    sort INT DEFAULT 0 COMMENT '排序',
    leader_id BIGINT DEFAULT 0 COMMENT '部门负责人ID',
    status TINYINT DEFAULT 1 COMMENT '状态 0禁用 1启用',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    is_deleted TINYINT DEFAULT 0 COMMENT '是否删除 0未删除 1已删除',
    PRIMARY KEY (id),
    KEY idx_parent_id (parent_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='部门表';

-- 8.岗位表
DROP TABLE IF EXISTS position;
CREATE TABLE position (
    id BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    post_name VARCHAR(64) NOT NULL COMMENT '岗位名称',
    dept_id BIGINT NOT NULL COMMENT '所属部门ID',
    sort INT DEFAULT 0 COMMENT '排序',
    remark VARCHAR(255) DEFAULT '' COMMENT '备注',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    is_deleted TINYINT DEFAULT 0 COMMENT '是否删除 0未删除 1已删除',
    PRIMARY KEY (id),
    KEY idx_dept_id (dept_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='岗位表';

-- 9.员工主表
DROP TABLE IF EXISTS employee;
CREATE TABLE employee (
    id BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    emp_code VARCHAR(32) NOT NULL COMMENT '员工编号',
    emp_name VARCHAR(32) NOT NULL COMMENT '员工姓名',
    gender TINYINT DEFAULT 0 COMMENT '性别 0未知 1男 2女',
    birthday DATE DEFAULT NULL COMMENT '出生日期',
    id_card VARCHAR(32) DEFAULT '' COMMENT '身份证号',
    phone VARCHAR(20) DEFAULT '' COMMENT '手机号',
    dept_id BIGINT DEFAULT 0 COMMENT '部门ID',
    post_id BIGINT DEFAULT 0 COMMENT '岗位ID',
    entry_date DATE DEFAULT NULL COMMENT '入职日期',
    work_status TINYINT DEFAULT 1 COMMENT '工作状态 1在职 2离职 3休假',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    is_deleted TINYINT DEFAULT 0 COMMENT '是否删除 0未删除 1已删除',
    PRIMARY KEY (id),
    UNIQUE KEY uk_emp_code (emp_code),
    KEY idx_dept_id (dept_id),
    KEY idx_post_id (post_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='员工主表';

-- 10.员工账号表
DROP TABLE IF EXISTS emp_user;
CREATE TABLE emp_user (
    id BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    emp_id BIGINT NOT NULL COMMENT '员工ID',
    username VARCHAR(64) NOT NULL COMMENT '登录账号',
    password VARCHAR(100) NOT NULL COMMENT '登录密码',
    role_type TINYINT DEFAULT 1 COMMENT '角色类型 1普通员工 2部门主管 3管理员 4财务',
    status TINYINT DEFAULT 1 COMMENT '状态 0禁用 1启用',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    is_deleted TINYINT DEFAULT 0 COMMENT '是否删除 0未删除 1已删除',
    PRIMARY KEY (id),
    UNIQUE KEY uk_username (username),
    KEY idx_emp_id (emp_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='员工账号表';

-- 11.员工年假&调休余额表
DROP TABLE IF EXISTS emp_annual_leave;
CREATE TABLE emp_annual_leave (
    id BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    emp_id BIGINT NOT NULL COMMENT '关联员工ID',
    leave_year INT NOT NULL COMMENT '年假所属年份',
    total_leave_days DECIMAL(5,2) DEFAULT 0.00 COMMENT '当年总年假天数',
    used_leave_days DECIMAL(5,2) DEFAULT 0.00 COMMENT '已使用年假天数',
    remain_leave_days DECIMAL(5,2) DEFAULT 0.00 COMMENT '剩余可休年假天数',
    compensatory_days DECIMAL(5,2) DEFAULT 0.00 COMMENT '累计调休剩余天数',
    freeze_status TINYINT DEFAULT 0 COMMENT '0正常 1冻结不可用',
    remark VARCHAR(255) DEFAULT '' COMMENT '备注说明',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    is_deleted TINYINT DEFAULT 0 COMMENT '是否删除 0未删除 1已删除',
    PRIMARY KEY (id),
    KEY idx_emp_id (emp_id),
    KEY idx_leave_year (leave_year)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='员工年假调休余额表';

-- 12.员工班次关联表
DROP TABLE IF EXISTS emp_shift_relation;
CREATE TABLE emp_shift_relation (
    id BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    emp_id BIGINT NOT NULL COMMENT '员工ID',
    shift_id BIGINT NOT NULL COMMENT '班次ID',
    effective_date DATE DEFAULT NULL COMMENT '生效日期',
    expire_date DATE DEFAULT NULL COMMENT '失效日期',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    is_deleted TINYINT DEFAULT 0 COMMENT '是否删除 0未删除 1已删除',
    PRIMARY KEY (id),
    KEY idx_emp_id (emp_id),
    KEY idx_shift_id (shift_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='员工班次关联表';

-- 13.考勤原始记录表
DROP TABLE IF EXISTS attend_record;
CREATE TABLE attend_record (
    id BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    emp_id BIGINT NOT NULL COMMENT '员工ID',
    attend_date DATE NOT NULL COMMENT '打卡日期',
    check_in_time DATETIME DEFAULT NULL COMMENT '签到时间',
    check_out_time DATETIME DEFAULT NULL COMMENT '签退时间',
    check_type TINYINT DEFAULT 1 COMMENT '打卡类型 1正常打卡 2补卡 3异地打卡',
    device_info VARCHAR(255) DEFAULT '' COMMENT '打卡设备信息',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    is_deleted TINYINT DEFAULT 0 COMMENT '是否删除 0未删除 1已删除',
    PRIMARY KEY (id),
    KEY idx_emp_id (emp_id),
    KEY idx_attend_date (attend_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='考勤原始记录表';

-- 14.考勤结果表
DROP TABLE IF EXISTS attend_result;
CREATE TABLE attend_result (
    id BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    emp_id BIGINT NOT NULL COMMENT '员工ID',
    attend_date DATE NOT NULL COMMENT '考勤日期',
    shift_id BIGINT DEFAULT 0 COMMENT '当日班次ID',
    real_work_hours DECIMAL(4,2) DEFAULT 0.00 COMMENT '实际出勤工时',
    attend_status TINYINT DEFAULT 1 COMMENT '考勤状态 1正常 2迟到 3早退 4旷工 5请假',
    late_minutes INT DEFAULT 0 COMMENT '迟到分钟数',
    early_minutes INT DEFAULT 0 COMMENT '早退分钟数',
    absent_days DECIMAL(4,2) DEFAULT 0.00 COMMENT '旷工天数',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    is_deleted TINYINT DEFAULT 0 COMMENT '是否删除 0未删除 1已删除',
    PRIMARY KEY (id),
    KEY idx_emp_id (emp_id),
    KEY idx_attend_date (attend_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='考勤结果表';

-- 15.请假申请表
DROP TABLE IF EXISTS attend_leave;
CREATE TABLE attend_leave (
    id BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    emp_id BIGINT NOT NULL COMMENT '员工ID',
    leave_type TINYINT DEFAULT 1 COMMENT '请假类型 1事假 2病假 3年假 4调休',
    start_time DATETIME NOT NULL COMMENT '开始时间',
    end_time DATETIME NOT NULL COMMENT '结束时间',
    leave_days DECIMAL(4,2) NOT NULL COMMENT '请假天数',
    remark VARCHAR(255) DEFAULT '' COMMENT '请假原因',
    approve_status TINYINT DEFAULT 0 COMMENT '审核状态 0待审核 1通过 2拒绝',
    approve_id BIGINT DEFAULT 0 COMMENT '审批人ID',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    is_deleted TINYINT DEFAULT 0 COMMENT '是否删除 0未删除 1已删除',
    PRIMARY KEY (id),
    KEY idx_emp_id (emp_id),
    KEY idx_approve_status (approve_status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='请假申请表';

-- 16.加班申请表
DROP TABLE IF EXISTS attend_overtime;
CREATE TABLE attend_overtime (
    id BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    emp_id BIGINT NOT NULL COMMENT '员工ID',
    overtime_date DATE NOT NULL COMMENT '加班日期',
    start_time DATETIME NOT NULL COMMENT '开始时间',
    end_time DATETIME NOT NULL COMMENT '结束时间',
    overtime_hours DECIMAL(4,2) NOT NULL COMMENT '加班小时数',
    overtime_reason VARCHAR(255) DEFAULT '' COMMENT '加班原因',
    approve_status TINYINT DEFAULT 0 COMMENT '审核状态 0待审核 1通过 2拒绝',
    approve_id BIGINT DEFAULT 0 COMMENT '审批人ID',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    is_deleted TINYINT DEFAULT 0 COMMENT '是否删除 0未删除 1已删除',
    PRIMARY KEY (id),
    KEY idx_emp_id (emp_id),
    KEY idx_approve_status (approve_status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='加班申请表';

-- 17.薪资模板表
DROP TABLE IF EXISTS salary_template;
CREATE TABLE salary_template (
    id BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    template_name VARCHAR(64) NOT NULL COMMENT '模板名称',
    basic_salary DECIMAL(10,2) DEFAULT 0.00 COMMENT '基本工资',
    post_salary DECIMAL(10,2) DEFAULT 0.00 COMMENT '岗位工资',
    performance_salary DECIMAL(10,2) DEFAULT 0.00 COMMENT '绩效工资',
    allowance DECIMAL(10,2) DEFAULT 0.00 COMMENT '补贴',
    social_insurance DECIMAL(10,2) DEFAULT 0.00 COMMENT '社保个人比例',
    housing_fund DECIMAL(10,2) DEFAULT 0.00 COMMENT '公积金个人比例',
    status TINYINT DEFAULT 1 COMMENT '状态 0禁用 1启用',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    is_deleted TINYINT DEFAULT 0 COMMENT '是否删除 0未删除 1已删除',
    PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='薪资模板表';

-- 18.员工薪资配置表
DROP TABLE IF EXISTS emp_salary_config;
CREATE TABLE emp_salary_config (
    id BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    emp_id BIGINT NOT NULL COMMENT '员工ID',
    template_id BIGINT NOT NULL COMMENT '薪资模板ID',
    tax_type TINYINT DEFAULT 1 COMMENT '计税方式 1正常计税',
    effective_date DATE DEFAULT NULL COMMENT '生效日期',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    is_deleted TINYINT DEFAULT 0 COMMENT '是否删除 0未删除 1已删除',
    PRIMARY KEY (id),
    KEY idx_emp_id (emp_id),
    KEY idx_template_id (template_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='员工薪资配置表';

-- 19.月度薪资统计表
DROP TABLE IF EXISTS salary_month_stat;
CREATE TABLE salary_month_stat (
    id BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    emp_id BIGINT NOT NULL COMMENT '员工ID',
    salary_year INT NOT NULL COMMENT '薪资年份',
    salary_month INT NOT NULL COMMENT '薪资月份',
    basic_salary DECIMAL(10,2) DEFAULT 0.00 COMMENT '基本工资',
    post_salary DECIMAL(10,2) DEFAULT 0.00 COMMENT '岗位工资',
    performance_salary DECIMAL(10,2) DEFAULT 0.00 COMMENT '绩效工资',
    overtime_salary DECIMAL(10,2) DEFAULT 0.00 COMMENT '加班工资',
    attend_deduct DECIMAL(10,2) DEFAULT 0.00 COMMENT '考勤扣款',
    social_insurance DECIMAL(10,2) DEFAULT 0.00 COMMENT '社保个人',
    housing_fund DECIMAL(10,2) DEFAULT 0.00 COMMENT '公积金个人',
    personal_tax DECIMAL(10,2) DEFAULT 0.00 COMMENT '个人所得税',
    should_salary DECIMAL(10,2) DEFAULT 0.00 COMMENT '应发工资',
    real_salary DECIMAL(10,2) DEFAULT 0.00 COMMENT '实发工资',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    is_deleted TINYINT DEFAULT 0 COMMENT '是否删除 0未删除 1已删除',
    PRIMARY KEY (id),
    KEY idx_emp_id (emp_id),
    KEY idx_year_month (salary_year, salary_month)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='月度薪资统计表';

-- 20.薪资发放记录表
DROP TABLE IF EXISTS salary_pay_record;
CREATE TABLE salary_pay_record (
    id BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    stat_id BIGINT NOT NULL COMMENT '薪资统计ID',
    emp_id BIGINT NOT NULL COMMENT '员工ID',
    pay_time DATETIME DEFAULT NULL COMMENT '发放时间',
    pay_type TINYINT DEFAULT 1 COMMENT '发放方式 1银行转账 2现金',
    pay_status TINYINT DEFAULT 0 COMMENT '发放状态 0未发放 1已发放',
    pay_voucher VARCHAR(255) DEFAULT '' COMMENT '发放凭证',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    is_deleted TINYINT DEFAULT 0 COMMENT '是否删除 0未删除 1已删除',
    PRIMARY KEY (id),
    KEY idx_stat_id (stat_id),
    KEY idx_emp_id (emp_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='薪资发放记录表';