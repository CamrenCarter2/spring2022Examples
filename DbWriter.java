import java.sql.*;

public class DbWriter {

	private static final String INSERT_STUDENT_STMT =
		"INSERT INTO students VALUES (NULL, ?, ?)";

	private static final String UNENROLL_STUDENT_STMT =
		"UPDATE enrollment " +
		"SET dropDate = CURRENT_DATE " +
		"WHERE studentId = ? AND classId = ?";

	public static void main(String[] args) {

		try {

			// first connect to the database
			Connection con = DriverManager.getConnection(
				"jdbc:mysql://localhost:3306/classRegistration",
				"newbie",
				"testing"
			);

			int rowsAffected = 0;

			if(args[0].equals("1")) {

				PreparedStatement stmt = con.prepareStatement(INSERT_STUDENT_STMT);
				stmt.setString(1, args[1]);
				stmt.setString(2, args[2]);
				rowsAffected = stmt.executeUpdate();
			} else if(args[0].equals("2")) {

                                PreparedStatement stmt = con.prepareStatement(UNENROLL_STUDENT_STMT);
                                stmt.setString(1, args[1]);
                                stmt.setString(2, args[2]);
                                rowsAffected = stmt.executeUpdate();
			} else {
				System.out.println("Unrecognized option");
			}

			System.out.println(rowsAffected + " rows inserted");

		} catch(Exception e) {
			System.out.println(e.getMessage());
		}
	}
}
