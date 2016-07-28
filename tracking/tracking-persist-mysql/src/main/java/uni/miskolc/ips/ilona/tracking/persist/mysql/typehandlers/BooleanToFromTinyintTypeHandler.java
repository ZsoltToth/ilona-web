package uni.miskolc.ips.ilona.tracking.persist.mysql.typehandlers;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.ibatis.type.BaseTypeHandler;
import org.apache.ibatis.type.JdbcType;

public class BooleanToFromTinyintTypeHandler extends BaseTypeHandler<Boolean> {

	@Override
	public Boolean getNullableResult(ResultSet arg0, String arg1) throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Boolean getNullableResult(ResultSet arg0, int arg1) throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Boolean getNullableResult(CallableStatement arg0, int arg1) throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void setNonNullParameter(PreparedStatement ps, int i, Boolean parameter, JdbcType type) throws SQLException {
		int value = 0;
		if (parameter == true) {
			value = 1;
		}
		ps.setInt(i, value);
	}

}
