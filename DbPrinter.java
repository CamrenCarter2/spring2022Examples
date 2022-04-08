import java.sql.*;

public class DbPrinter {

	private static final String ALL_STUDENT_QUERY =
		"SELECT * FROM students ORDER BY lastName";

	private static final String ALL_CLASSES_QUERY =
		"SELECT * FROM classes ORDER BY classId";

	private static final String CURRENT_ENROLLMENT_QUERY =
		"SELECT classes.name, students.studentId, students.firstName, " +
			"students.lastName ,enrollment.enrollmentDate " +
		"FROM classes, enrollment, students " +
		"WHERE enrollment.dropDate IS NULL " +
			"AND enrollment.studentId = students.studentId " +
			"AND enrollment.classId = classes.classId " +
		"ORDER BY classes.name";

	public static void main(String[] args) {

		try {

			// first connect to the database
			Connection con = DriverManager.getConnection(
				"jdbc:mysql://localhost:3306/csc121example",
				"newbie",
				"testing"
			);


			// next prepate a query
			Statement stmt = con.createStatement();

			// build the query
			stmt.executeQuery(ALL_STUDENT_QUERY);
			printStudentQryResult(stmt.getResultSet());

			System.out.println("");

			stmt.executeQuery(ALL_CLASSES_QUERY);
			printClassQryResult(stmt.getResultSet());

			System.out.println("");

			stmt.executeQuery(CURRENT_ENROLLMENT_QUERY);
			printEnrollmentQryResult(stmt.getResultSet());

			
		} catch(Exception e) {
			System.out.println(e.getMessage());
		}
	}

	private static void printEnrollmentQryResult(ResultSet rs) throws SQLException {

		System.out.println("Current Enrollment:");
		while(rs.next()) {
			StringBuilder builder = new StringBuilder("");

			builder.append("[" + rs.getString(2) + "] ");
			builder.append(rs.getString(4) + ", ");
			builder.append(rs.getString(3) + ": ");
			builder.append(rs.getString(1));

			System.out.println(builder.toString());
		}
	}

	private static void printStudentQryResult(ResultSet rs) throws SQLException {

		System.out.println("All students in the system:");
		while(rs.next()) {
			StringBuilder builder = new StringBuilder("");

			builder.append(rs.getString(2) + " ");
			builder.append(rs.getString(3) + " (");
			builder.append(rs.getString(1) + ")");

			System.out.println(builder.toString());
		}
	}

	private static void printClassQryResult(ResultSet rs) throws SQLException {

		System.out.println("All classes in the system:");
		while(rs.next()) {
			StringBuilder builder = new StringBuilder("");

			builder.append(rs.getString(3) + " (ID ");
			builder.append(rs.getString(1) + ")\n");
			builder.append("\tLocation: ");
			builder.append(rs.getString(4) + "\n");
			builder.append("\tOffered: ");
			builder.append(rs.getString(2));

			System.out.println(builder.toString());
		}
	}
}
