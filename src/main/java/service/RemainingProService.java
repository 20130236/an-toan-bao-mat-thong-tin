package service;

import dao.DBConnection;
import model.Product;
import model.RemainingProducts;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class RemainingProService {
    public static List<RemainingProducts> getAllProduct() {
        List<RemainingProducts> list = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        String sql;
        try {
            sql = "SELECT product_id, SUM(COALESCE(import_quantity, 0)) AS total_import_quantity, SUM(COALESCE(sold_quantity, 0)) AS total_sold_quantity, SUM(COALESCE(remaining_quantity, 0)) AS total_remaining_quantity\n" +
                    "FROM (\n" +
                    "    SELECT product_id, SUM(quantity) AS import_quantity, NULL AS sold_quantity, NULL AS remaining_quantity\n" +
                    "    FROM import_products\n" +
                    "    GROUP BY product_id\n" +
                    "\n" +
                    "    UNION ALL\n" +
                    "\n" +
                    "    SELECT id_product, NULL, SUM(amount), NULL\n" +
                    "    FROM order_detail\n" +
                    "    GROUP BY id_product\n" +
                    "\n" +
                    "    UNION ALL\n" +
                    "\n" +
                    "    SELECT ip.product_id, NULL, NULL, ip.quantity - COALESCE(od.sold_quantity, 0) AS remaining_quantity\n" +
                    "    FROM import_products ip\n" +
                    "    LEFT JOIN (\n" +
                    "        SELECT id_product, SUM(amount) AS sold_quantity\n" +
                    "        FROM order_detail\n" +
                    "        GROUP BY id_product\n" +
                    "    ) od ON ip.product_id = od.id_product\n" +
                    ") AS combined_results\n" +
                    "GROUP BY product_id;\n";
            ps = DBConnection.getConnection().prepareStatement(sql);
            list = new ArrayList<>();
            rs = ps.executeQuery(sql);
            while (rs.next()) {
                RemainingProducts p = new RemainingProducts(rs.getInt(1), rs.getInt(2), rs.getInt(3), rs.getInt(4));
                list.add(p);

            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
        return list;
    }
    public static int getRemaining(int id) {
        int pro = 0;
        Connection connection = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        String sql = "SELECT product_id, SUM(COALESCE(total_remaining_quantity, 0)) AS total_remaining_quantity\n" +
                "FROM (\n" +
                "    SELECT ip.product_id, ip.quantity - COALESCE(od.sold_quantity, 0) AS total_remaining_quantity\n" +
                "    FROM import_products ip\n" +
                "    LEFT JOIN (\n" +
                "        SELECT id_product, SUM(amount) AS sold_quantity\n" +
                "        FROM order_detail\n" +
                "        GROUP BY id_product\n" +
                "    ) od ON ip.product_id = od.id_product\n" +
                ") AS combined_results\n" +
                "WHERE product_id = ?\n" +
                "GROUP BY product_id";

        try {
            connection = DBConnection.getConnection();
            ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            if (rs.next()) {
                pro = rs.getInt("total_remaining_quantity");
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (connection != null) {
                    ((Connection) connection).close();
                }
            } catch (SQLException e) {
                // Xử lý ngoại lệ khi đóng kết nối và các đối tượng
            }
        }

        return pro;
    }

}
