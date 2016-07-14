package uni.miskolc.ips.ilona.tracking.persist.mysql;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.ibatis.type.BaseTypeHandler;
import org.apache.ibatis.type.JdbcType;

public class BooleanEnabledTypeHandler extends BaseTypeHandler<Boolean> {

	@Override
	public void setNonNullParameter(PreparedStatement ps, int i, Boolean parameter, JdbcType jdbcType)
			throws SQLException {
		int value = 0;
		if (parameter == true) {
			value = 1;
		}
		ps.setInt(i, value);
	}

	@Override
	public Boolean getNullableResult(ResultSet rs, String columnName) throws SQLException {
		int value = rs.getInt(columnName);
		if (value == 1) {
			return true;
		} else {
			return false;
		}
	}

	@Override
	public Boolean getNullableResult(ResultSet rs, int columnIndex) throws SQLException {
		int value = rs.getInt(columnIndex);
		if (value == 1) {
			return true;
		} else {
			return false;
		}
	}

	@Override
	public Boolean getNullableResult(CallableStatement cs, int columnIndex) throws SQLException {		
		int value = cs.getInt(columnIndex);
		if (value == 1) {
			return true;
		} else {
			return false;
		}
	}

}
