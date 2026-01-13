<?php
//namespace LogHelper;

class LogHelper
{
    /** Log file path */
    public static string $file = __DIR__ . DIRECTORY_SEPARATOR . 'LogHelper.log';

    /** Regex sensitive data, e.g. password, token. */
    public static array $regexes = [
        '/(?<=password":")(.*?)(?=\")/',
        '/(?<=token":")(.*?)(?=\")/',
        '/(?<=token )(.*?)(?=\")/'
    ];

    /** Log an informational message. */
    public static function logInfo(mixed $message): bool
    {
        return self::writeToFile($message, 'INF');
    }

    /** Log an error message. */
    public static function logError(mixed $message): bool
    {
        return self::writeToFile($message, 'ERR');
    }

    /** Log an debug message. */
    public static function logDebug(mixed $message): bool
    {
        return self::writeToFile($message, 'DBG');
    }

    /** Change object / array to string, normalize whitespace */
    private static function processMessage(mixed $message, string $level): string
    {
        if (empty($message)) $message = '-empty-';

        // convert message to string
        if (is_object($message) || is_array($message)) {
            $message = json_encode($message, JSON_UNESCAPED_SLASHES | JSON_UNESCAPED_UNICODE);
            if (json_last_error() !== JSON_ERROR_NONE) $message = var_export($message, true);
        }

        // line endings, whitespace
        $message = str_replace(array("\r", "\n"), ' ', $message);
        $message = preg_replace('!\s+!', ' ', $message);

        // get debug backtrace
        $backTrace = debug_backtrace(DEBUG_BACKTRACE_IGNORE_ARGS, 3);
        $message = date('Y-m-d H:i:s') . substr(microtime(), 1, 4) . ' ' . $level . ' ' .
            $backTrace[2]['class'] . '\\' . $backTrace[2]['function'] . ': ' . $message . "\n";

        // add extra debug information if debug level
        if ($level === 'DBG') {
            $backTrace = debug_backtrace(DEBUG_BACKTRACE_IGNORE_ARGS);
            $message .= '                            ' . json_encode($backTrace, JSON_UNESCAPED_SLASHES) . "\n";
        }

        // remove sensitive information such as passwords
        // do this after converting to json
        foreach (self::$regexes as $index => $regex) {
            $matches = [];
            preg_match($regex, $message, $matches);
            if (!empty($matches[0]))
                $message = str_replace($matches[0], '*****', $message);
        }

        return $message;
    }

    /** Write message to a log file. */
    private static function writeToFile(mixed $message, string $level): bool
    {
        return error_log(self::processMessage($message, $level), 3, self::$file);
    }
}
