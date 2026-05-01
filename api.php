<?php
// api.php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

$host = "localhost";
$user = "root";
$pass = "";
$dbname = "library_db"; 

$conn = new mysqli($host, $user, $pass, $dbname);
if ($conn->connect_error) { die(json_encode(["error" => $conn->connect_error])); }

$action = isset($_GET['action']) ? $_GET['action'] : '';

$data = [];


switch ($action) {
    case 'get_books':
        // Query 1 & 2: Search and Filter
        $sql = "SELECT b.*, c.category_name, s.quantity 
                FROM books b 
                LEFT JOIN categories c ON b.category_id = c.category_id
                LEFT JOIN stock s ON b.book_id = s.book_id 
                WHERE 1=1";
        
        if (isset($_GET['search']) && !empty($_GET['search'])) {
            $search = $conn->real_escape_string($_GET['search']);
            $sql .= " AND b.title LIKE '%$search%'";
        }
        if (isset($_GET['sort']) && $_GET['sort'] == 'price') {
            $sql .= " ORDER BY b.price ASC";
        } else {
            $sql .= " ORDER BY b.title ASC"; // Default sort (Query 1)
        }
        break;

    case 'get_stats_categories':
        // Query 5: Count books in each category
        $sql = "SELECT c.category_name, COUNT(b.book_id) as count 
                FROM categories c 
                LEFT JOIN books b ON c.category_id = b.category_id 
                GROUP BY c.category_id";
        break;

    case 'get_low_stock':
        // Query 4: Books with low stock (< 10)
        $sql = "SELECT b.title, s.quantity 
                FROM books b 
                JOIN stock s ON b.book_id = s.book_id 
                WHERE s.quantity < 10";
        break;

    case 'get_overdue_rentals':
        // Query 11: Overdue rentals
        $sql = "SELECT r.*, b.title, c.customer_name 
                FROM rentals r
                JOIN books b ON r.book_id = b.book_id
                JOIN customers c ON r.customer_id = c.customer_id
                WHERE r.return_date IS NULL AND r.due_date < NOW()";
        break;

    case 'get_sales_revenue':
        // Query 7: Total sales revenue
        $sql = "SELECT SUM(amount) as total_revenue FROM sales";
        break;

    default:
        echo json_encode(["error" => "Invalid Action"]);
        exit;
}

if (isset($sql)) {
    $result = $conn->query($sql);
    if ($result) {
        while ($row = $result->fetch_assoc()) {
            $data[] = $row;
        }
    }
}

echo json_encode($data);
$conn->close();
?>