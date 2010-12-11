<!DOCTYPE html>
<html>
    <head>
        <title>Images</title>
    </head>

    <body>
        <?php
        echo "<table>\n";
        echo "\t\t<tr>\n";

        $i = 0;
        if ($handle = opendir(".")) {
            while (false !== ($file = readdir($handle))) {
                if (strstr($file, "png")||strstr($file, "jpg")||strstr($file, "bmp")||strstr($file, "gif")) {
                    echo "\t\t\t<td><a href='".$file."'><img src='".$file."' width='200px' /></a></td>\n";
                    $i++;
                    if ($i%5 == 0) {
                        echo "\t\t</tr>\n\t\t<tr>\n";
                    }
                }
            }
            closedir($handle);
        }

        echo "\t\t</tr>\n";
        echo "\t</table>\n";
        ?>
    </body>
</html>
