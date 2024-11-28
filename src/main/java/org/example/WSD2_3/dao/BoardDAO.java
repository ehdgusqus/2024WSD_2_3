package org.example.WSD2_3.dao;

import org.example.WSD2_3.bean.BoardVO;
import org.example.WSD2_3.util.JDBCUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class BoardDAO {
    String insert = "INSERT INTO BOARD (title, writer, score, content, file_path) VALUES (?,?,?,?,?)";
    String update = "UPDATE BOARD SET title=?, writer=?, score=?, content=?, file_path=? WHERE id=?";
    String delete = "DELETE FROM BOARD WHERE id=?";
    String select_id = "SELECT * FROM BOARD WHERE id=?";
    String table = "SELECT * FROM BOARD";
    String search = "SELECT * FROM BOARD WHERE title LIKE ? OR content LIKE ?";
    String updateView = "UPDATE BOARD SET view = view + 1 WHERE id = ?";

    // 생성한 vo를 파라미터로 입력 받은 후에 DB에 집어넣음
    public boolean insertBoard(BoardVO vo){
        try(Connection conn = JDBCUtil.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(insert)){

            pstmt.setString(1, vo.getTitle());
            pstmt.setString(2, vo.getWriter());
            pstmt.setInt(3, vo.getScore());
            pstmt.setString(4, vo.getContent());
            pstmt.setString(5, vo.getFile_path());

            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    // 새로 생성한 vo와 수정할 id를 파라미터로 입력받음
    // id에 해당하는 테이블을 파라미터로 입력받은 vo로 변경
    public boolean updateBoard(BoardVO vo, int id) {
        try (Connection conn = JDBCUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(update)) {

            pstmt.setString(1, vo.getTitle());
            pstmt.setString(2, vo.getWriter());
            pstmt.setInt(3, vo.getScore());
            pstmt.setString(4, vo.getContent());
            pstmt.setString(5, vo.getFile_path());
            pstmt.setInt(6, id);

            int rowsAffected = pstmt.executeUpdate();
            System.out.println("Rows affected: " + rowsAffected);
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }


    // 테이블의 id가 주어졌을 때, 해당 id를 삭제
    public boolean deleteBoard(int id){
        try(Connection conn = JDBCUtil.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(delete)){

            pstmt.setInt(1, id);

            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    // 테이블의 id가 주어졌을 때, id에 해당하는 VO를 리턴
    public BoardVO getBoard(int id) {
        try (Connection conn = JDBCUtil.getConnection()) {
            // View 값 증가
            try (PreparedStatement updateStmt = conn.prepareStatement(updateView)) {
                updateStmt.setInt(1, id);
                updateStmt.executeUpdate();
            }

            // 데이터 조회
            try (PreparedStatement selectStmt = conn.prepareStatement(select_id)) {
                selectStmt.setInt(1, id);
                try (ResultSet rs = selectStmt.executeQuery()) {
                    if (rs.next()) {
                        BoardVO vo = new BoardVO();
                        vo.setId(rs.getInt("id"));
                        vo.setTitle(rs.getString("title"));
                        vo.setWriter(rs.getString("writer"));
                        vo.setScore(rs.getInt("score"));
                        vo.setContent(rs.getString("content"));
                        vo.setCreate_date(rs.getDate("create_date"));
                        vo.setFile_path(rs.getString("file_path"));
                        vo.setView(rs.getInt("view"));
                        return vo;
                    }
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return null; // 해당 id에 값이 없으면 null 반환
    }


    // 테이블 전체를 list로 제작하여 리턴
    public List<BoardVO> getBoardList(){
        List<BoardVO> list = new ArrayList<>();

        try(Connection conn = JDBCUtil.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(table)){

            ResultSet rs = pstmt.executeQuery();

            while(rs.next()){
                BoardVO vo = new BoardVO();
                vo.setId(rs.getInt("id"));
                vo.setTitle(rs.getString("title"));
                vo.setWriter(rs.getString("writer"));
                vo.setScore(rs.getInt("score"));
                vo.setContent(rs.getString("content"));
                vo.setFile_path(rs.getString("file_path"));

                list.add(vo);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return list;
    }

    // 파라미터로 주어진 title과 content에 해당하는 테이블을 리턴(vo 리턴)
    public List<BoardVO> searchBoard(String title, String content) {
        List<BoardVO> searchResults = new ArrayList<>();

        try(Connection conn = JDBCUtil.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(search)) {

            pstmt.setString(1, "%" + title + "%");
            pstmt.setString(2, "%" + content + "%");

            ResultSet rs = pstmt.executeQuery();

            while(rs.next()) {
                BoardVO vo = new BoardVO();
                vo.setId(rs.getInt("id"));
                vo.setTitle(rs.getString("title"));
                vo.setWriter(rs.getString("writer"));
                vo.setScore(rs.getInt("score"));
                vo.setContent(rs.getString("content"));
                vo.setCreate_date(rs.getDate("create_date"));
                vo.setFile_path(rs.getString("file_path"));

                searchResults.add(vo);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return searchResults;
    }

}
