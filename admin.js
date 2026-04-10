/**
 * 企业员工考勤与薪资管理系统
 * 前端业务JS + 模拟数据
 * 对应20张数据库表 | 5大业务模块
 */

// ====================== 1. 全局配置 & 模拟数据 ======================
const systemConfig = {
    systemName: "考勤与薪资管理系统",
    currentUser: {
        id: 1,
        username: "admin",
        name: "管理员",
        role: 3
    }
};

// 模拟数据库统计数据（对应20张表统计）
const dashboardData = {
    employeeCount: 126,        // 员工表
    attendanceRate: "98.6%",  // 考勤结果表
    pendingApprove: 12,       // 请假+加班申请表
    pendingSalary: 8          // 薪资发放记录表
};

// 今日考勤列表
const todayAttendanceList = [
    { name: "张三", dept: "技术部", status: "正常", time: "08:25", tag: "blue" },
    { name: "李四", dept: "人事部", status: "迟到", time: "09:06", tag: "orange" },
    { name: "王五", dept: "财务部", status: "正常", time: "08:29", tag: "blue" }
];

// 待审批列表
const pendingApproveList = [
    { type: "请假", name: "赵六", time: "04-05", status: "待审核", tag: "orange" },
    { type: "加班", name: "钱七", time: "04-04", status: "待审核", tag: "orange" },
    { type: "请假", name: "孙八", time: "04-03", status: "已通过", tag: "green" }
];

// 待发放薪资
const salaryList = [
    { name: "张三", dept: "技术部", should: "¥9800.00", real: "¥8965.50", status: "待发放", tag: "orange" },
    { name: "李四", dept: "人事部", should: "¥7500.00", real: "¥6820.30", status: "待发放", tag: "orange" },
    { name: "王五", dept: "财务部", should: "¥8600.00", real: "¥7791.20", status: "已发放", tag: "green" }
];

// ====================== 2. 页面初始化 ======================
document.addEventListener('DOMContentLoaded', function () {
    console.log("✅ 考勤薪资系统加载完成");
    initPage();       // 初始化页面
    bindMenuEvent();  // 绑定菜单事件
});

// 页面数据渲染
function initPage() {
    // 渲染顶部用户名
    document.querySelector(".user span").innerText = systemConfig.currentUser.name;

    // 渲染统计卡片
    const cards = document.querySelectorAll(".card .num");
    cards[0].innerText = dashboardData.employeeCount;
    cards[1].innerText = dashboardData.attendanceRate;
    cards[2].innerText = dashboardData.pendingApprove;
    cards[3].innerText = dashboardData.pendingSalary;

    // 渲染表格
    renderTable("todayAttendanceTable", todayAttendanceList, renderAttendanceRow);
    renderTable("pendingApproveTable", pendingApproveList, renderApproveRow);
    renderTable("salaryTable", salaryList, renderSalaryRow);
}

// ====================== 3. 通用表格渲染工具 ======================
function renderTable(tableId, data, rowFunc) {
    const table = document.getElementById(tableId);
    if (!table) return;
    const tbody = table.querySelector("tbody") || table;
    data.forEach(item => {
        const tr = document.createElement("tr");
        tr.innerHTML = rowFunc(item);
        tbody.appendChild(tr);
    });
}

// 考勤行
function renderAttendanceRow(item) {
    return `
        <td>${item.name}</td>
        <td>${item.dept}</td>
        <td><span class="tag ${item.tag}">${item.status}</span></td>
        <td>${item.time}</td>
    `;
}

// 审批行
function renderApproveRow(item) {
    return `
        <td>${item.type}</td>
        <td>${item.name}</td>
        <td>${item.time}</td>
        <td><span class="tag ${item.tag}">${item.status}</span></td>
    `;
}

// 薪资行
function renderSalaryRow(item) {
    return `
        <td>${item.name}</td>
        <td>${item.dept}</td>
        <td>${item.should}</td>
        <td>${item.real}</td>
        <td><span class="tag ${item.tag}">${item.status}</span></td>
    `;
}

// ====================== 4. 侧边栏菜单点击事件 ======================
function bindMenuEvent() {
    const menuItems = document.querySelectorAll(".sidebar li");
    menuItems.forEach((item, index) => {
        item.onclick = function () {
            // 点击效果
            menuItems.forEach(i => i.style.background = "");
            this.style.background = "#34495e";

            // 获取菜单名
            const menuName = this.innerText.trim();
            console.log("切换菜单：" + menuName);
            switchPage(menuName);
        };
    });
}

// ====================== 5. 页面切换模拟 ======================
function switchPage(menuName) {
    const title = document.querySelector(".header .left");
    switch (menuName) {
        // 基础配置
        case "字典管理": title.innerText = "字典管理"; break;
        case "系统参数": title.innerText = "系统参数配置"; break;
        case "节假日": title.innerText = "节假日管理"; break;
        case "班次管理": title.innerText = "班次管理"; break;

        // 组织架构
        case "公司信息": title.innerText = "公司信息管理"; break;
        case "部门管理": title.innerText = "部门管理"; break;
        case "岗位管理": title.innerText = "岗位管理"; break;

        // 员工管理
        case "员工信息": title.innerText = "员工信息管理"; break;
        case "账号管理": title.innerText = "员工账号管理"; break;
        case "年假余额": title.innerText = "员工年假余额"; break;

        // 考勤管理
        case "员工班次": title.innerText = "员工班次分配"; break;
        case "打卡记录": title.innerText = "打卡记录查询"; break;
        case "考勤结果": title.innerText = "考勤结果统计"; break;
        case "请假申请": title.innerText = "请假申请审批"; break;
        case "加班申请": title.innerText = "加班申请审批"; break;

        // 薪资管理
        case "薪资模板": title.innerText = "薪资模板管理"; break;
        case "薪资配置": title.innerText = "员工薪资配置"; break;
        case "月度薪资": title.innerText = "月度薪资核算"; break;
        case "发放记录": title.innerText = "薪资发放记录"; break;

        default: title.innerText = "控制台首页";
    }
}

// ====================== 6. 通用业务方法（可用于毕设演示） ======================
// 审批通过
function approvePass(id) {
    alert("审批成功！ID：" + id);
}

// 审批拒绝
function approveReject(id) {
    alert("已拒绝！ID：" + id);
}

// 发放薪资
function paySalary(id) {
    if (confirm("确认发放该笔薪资？")) {
        alert("薪资发放成功！");
    }
}

// 退出登录
function logout() {
    if (confirm("确定退出登录？")) {
        window.location.href = "login.html";
    }
}

// 打印日志（方便调试）
console.log(`
📊 系统表结构说明：
1.基础配置(4) 2.组织架构(3) 3.员工管理(3) 4.考勤管理(5) 5.薪资管理(4) = 20张表
✅ JS已加载完成，支持菜单切换、数据渲染、模拟业务
`);