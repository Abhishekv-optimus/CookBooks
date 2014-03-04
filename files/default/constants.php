<?php
/**
 * Constants.php
 *
 * This file is intended to group all constants to
 * make it easier for the site administrator to tweak
 * the login script.
 *
 */

/**
 * Database Constants - these constants are required
 * in order for there to be a successful connection
 * to the MySQL database. Make sure the information is
 * correct.
 */


$httpHost = explode('.',$_SERVER["HTTP_HOST"]);
$subDomain = strtolower($httpHost[0]);

if ( "" != $_SERVER['DB_HOST'] ) {
    define("DB_SERVER", $_SERVER['DB_HOST']);
    define("DB_USER", $_SERVER['DB_USER']);
    define("DB_PASS", $_SERVER['DB_PASS']);
    define("DB_NAME", $_SERVER['DB_NAME']);
    define("UPLOAD_PATH", $_SERVER['UPLOAD_PATH']);
    define("UPLOAD_URL", $_SERVER['UPLOAD_URL']);
}
else if($_SERVER['REMOTE_ADDR'] == '127.0.0.1') {
	define("DB_SERVER", "localhost");
	define("DB_USER", "root");
	define("DB_PASS", "");
	define("DB_NAME", "smrt");
	define("UPLOAD_PATH", "C:\/xampp/htdocs/smrt/content/uploads/");
    define("UPLOAD_URL", "/content/uploads");
}
else if ( $subDomain == "dev" ) {
    define("DB_SERVER", "localhost");
	define("DB_USER", "admin_scott");
	define("DB_PASS", "df45sd34");
	define("DB_NAME", "admin_smrt");
	define("UPLOAD_PATH", "/home/admin/public_html/dev.smrtenglish.com/content/uploads/");
    define("UPLOAD_URL", "/content/uploads");
}
else {
	define("DB_SERVER", "smrtdb.cwcd4k9nvg5o.us-east-1.rds.amazonaws.com");
	define("DB_USER", "smrt_db_usr");
    define("DB_PASS", "8T01c52909");
    define("DB_NAME", "smrt_production");
    define("UPLOAD_PATH", "/var/www/smrt_production/content/uploads/");
    define("UPLOAD_URL", "/content/uploads");
}

/**
 * Database Table Constants - these constants
 * hold the names of all the database tables used
 * in the script.
 */
define("TBL_USERS", "smrt_users");
define("TBL_ACTIVE_USERS",  "smrt_active_users");
define("TBL_ACTIVE_GUESTS", "smrt_active_guests");
define("TBL_BANNED_USERS",  "smrt_banned_users");

/**
 * Special Names and Level Constants - the admin
 * page will only be accessible to the user with
 * the admin name and also to those users at the
 * admin user level. Feel free to change the names
 * and level constants as you see fit, you may
 * also add additional level specifications.
 * Levels must be digits between 0-9.
 */
define("ADMIN_NAME", "scottkeller@gmail.com");
define("GUEST_NAME", "Guest");
define("ADMIN_LEVEL", 9);
define("SCHOOL_ADMIN_LEVEL", 8);
define("AUTHOR_LEVEL", 5);
define("TEACHER_LEVEL", 2);
define("USER_LEVEL",  1);
define("GUEST_LEVEL", 0);

/**
 * This boolean constant controls whether or
 * not the script keeps track of active users
 * and active guests who are visiting the site.
 */
define("TRACK_VISITORS", true);

/**
 * Timeout Constants - these constants refer to
 * the maximum amount of time (in minutes) after
 * their last page fresh that a user and guest
 * are still considered active visitors.
 */
define("USER_TIMEOUT", 150);
define("GUEST_TIMEOUT", 5);

/**
 * Cookie Constants - these are the parameters
 * to the setcookie function call, change them
 * if necessary to fit your website. If you need
 * help, visit www.php.net for more info.
 * <http://www.php.net/manual/en/function.setcookie.php>
 */
define("COOKIE_EXPIRE", 60*60*24*100);  //100 days by default
define("COOKIE_PATH", "/");  //Avaible in whole domain

/**
 * Email Constants - these specify what goes in
 * the from field in the emails that the script
 * sends to users, and whether to send a
 * welcome email to newly registered users.
 */
define("EMAIL_FROM_NAME", "Smrt");
define("EMAIL_FROM_ADDR", "do-not-reply@smrt.com");
define("EMAIL_WELCOME", false);

/**
 * This constant forces all users to have
 * lowercase usernames, capital letters are
 * converted automatically.
 */
define("ALL_LOWERCASE", false);

/**
* Theme specfic constants
*/
//if ( $subDomain == "dev" || $subDomain == "www" || $subDomain == "ccel" ) {
//	define("THEME_FOLDER", "content/themes/smrt_3");
//}
//else {
	define("THEME_FOLDER", "content/themes/smrt_1");
//}
define("SITE_NAME", "Smrt English");
define("SITE_SLOGAN", "");


define('FACEBOOK_APP_ID', '192460754143720');
define('FACEBOOK_SECRET', '1bad6412af8d6e4f22698a1fb78a4e25');


define( 'DESIRED_IMAGE_WIDTH', 200 );
define( 'DESIRED_IMAGE_HEIGHT', 200 );

?>
