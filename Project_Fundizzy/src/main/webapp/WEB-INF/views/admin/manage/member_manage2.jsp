<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>관리자 페이지</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            display: flex;
        }
        .sidebar {
            width: 200px;
            background-color: #e7c5e6;
            padding: 20px;
            height: 100vh;
        }
        .sidebar h3 {
            margin-bottom: 10px;
        }
        .sidebar ul {
            list-style-type: none;
            padding: 0;
        }
        .sidebar ul li {
            margin: 10px 0;
        }
        .sidebar ul li a {
            color: black;
            text-decoration: none;
        }
        .main-content {
            flex-grow: 1;
            padding: 20px;
            background-color: #f9f9f9;
        }
        .recent-join {
            margin-bottom: 20px;
        }
        .recent-join h2 {
            margin-bottom: 10px;
            color: purple;
        }
        .recent-join p {
            margin: 5px 0;
        }
        .member-info {
            margin-top: 30px;
        }
        .member-info h2 {
            color: purple;
            margin-bottom: 10px;
        }
        .member-info table {
            width: 100%;
            border-collapse: collapse;
        }
        .member-info table th, .member-info table td {
            border-bottom: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        .member-info table th {
            background-color: #f2f2f2;
        }
        .search-bar {
            margin-bottom: 15px;
            display: flex;
            align-items: center;
        }
        .search-bar input[type="text"] {
            width: 200px;
            padding: 5px;
            margin-right: 10px;
        }
        .member-img {
            width: 50px;
            height: 50px;
            object-fit: cover;
        }
    </style>
</head>
<body>

<div class="sidebar">
    <h3>관리자 홈</h3>
    <ul>
        <li><a href="#">사용자 관리</a></li>
        <li><a href="#">회원관리</a></li>
        <li><a href="#">권리자 관리</a></li>
        <li><a href="#">프로젝트 관리</a></li>
        <li><a href="#">결제 및 정산 관리</a></li>
        <li><a href="#">커뮤니케이션 관리</a></li>
    </ul>
</div>

<div class="main-content">
    <!-- 최근 가입자 -->
    <div class="recent-join">
        <h2>최근 가입자</h2>
        <p>naver@naver.com<br><small>2025.02.17</small></p>
        <p>itwillbs.googel.com<br><small>2025.02.17</small></p>
    </div>

    <!-- 회원 정보 -->
    <div class="member-info">
        <h2>회원 정보</h2>
        <div class="search-bar">
            <input type="text" placeholder="회원명">
            <button>검색</button>
        </div>

        <table>
            <thead>
            <tr>
                <th>이메일</th>
                <th>가입 날짜</th>
                <th>상태</th>
                <th>이미지</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td>itwillbs.googel.com</td>
                <td>2025.02.17</td>
                <td>일반회원</td>
                <td><img src="path/to/image.jpg" alt="회원 이미지" class="member-img"></td>
            </tr>
            <tr>
                <td>itwillbs.googel.com</td>
                <td>2025.02.17</td>
                <td>일반회원</td>
                <td><img src="path/to/image.jpg" alt="회원 이미지" class="member-img"></td>
            </tr>
            <tr>
                <td>itwillbs.googel.com</td>
                <td>2025.02.17</td>
                <td>일반회원</td>
                <td><img src="path/to/image.jpg" alt="회원 이미지" class="member-img"></td>
            </tr>
            <tr>
                <td>itwillbs.googel.com</td>
                <td>2025.02.17</td>
                <td>일반회원</td>
                <td><img src="path/to/image.jpg" alt="회원 이미지" class="member-img"></td>
            </tr>
            </tbody>
        </table>
    </div>
</div>

</body>
</html>
