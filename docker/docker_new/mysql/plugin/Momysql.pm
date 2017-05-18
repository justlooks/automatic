package Collectd::Plugins::Momysql;

use strict;
use Collectd qw( :all );
use Data::Dumper;
use DBI;

my $dbh;
my $db_info={};

my $sql_opts = "show global status like 'Handler_read_next'";
my $mstats = {};

# do not check following status
my @exclude_status = [
        'ssl_accepts',
        'ssl_accept_renegotiates',
        'ssl_callback_cache_hits',
        'ssl_cipher',
        'ssl_cipher_list',
        'ssl_client_connects',
        'ssl_connect_renegotiates',
        'ssl_ctx_verify_depth',
        'ssl_ctx_verify_mode',
        'ssl_default_timeout',
        'ssl_finished_accepts',
        'ssl_finished_connects',
        'ssl_server_not_after',
        'ssl_server_not_before',
        'ssl_sessions_reused',
        'ssl_session_cache_hits',
        'ssl_session_cache_misses',
        'ssl_session_cache_mode',
        'ssl_session_cache_overflows',
        'ssl_session_cache_size',
        'ssl_session_cache_timeouts',
        'ssl_used_session_cache_entries',
        'ssl_verify_depth',
        'ssl_verify_mode',
        'ssl_version',
        'performance_schema_accounts_lost',
        'performance_schema_cond_classes_lost',
        'performance_schema_cond_instances_lost',
        'performance_schema_digest_lost',
        'performance_schema_file_classes_lost',
        'performance_schema_file_handles_lost',
        'performance_schema_file_instances_lost',
        'performance_schema_hosts_lost',
        'performance_schema_index_stat_lost',
        'performance_schema_locker_lost',
        'performance_schema_memory_classes_lost',
        'performance_schema_metadata_lock_lost',
        'performance_schema_mutex_classes_lost',
        'performance_schema_mutex_instances_lost',
        'performance_schema_nested_statement_lost',
        'performance_schema_prepared_statements_lost',
        'performance_schema_program_lost',
        'performance_schema_rwlock_classes_lost',
        'performance_schema_rwlock_instances_lost',
        'performance_schema_session_connect_attrs_lost',
        'performance_schema_socket_classes_lost',
        'performance_schema_socket_instances_lost',
        'performance_schema_stage_classes_lost',
        'performance_schema_statement_classes_lost',
        'performance_schema_table_handles_lost',
        'performance_schema_table_instances_lost',
        'performance_schema_table_lock_stat_lost',
        'performance_schema_thread_classes_lost',
        'performance_schema_thread_instances_lost',
        'performance_schema_users_lost',
# others
        'max_used_connections_time',
        'innodb_buffer_pool_load_status',
        'innodb_buffer_pool_dump_status'

        ];

# connect mysql database

sub foobar_init
{
    plugin_log(Collectd::LOG_INFO, "start init...$db_info->{host}");
    return 1;
}

# two level plugin xml
# put var in collectd.conf into hash
sub foobar_config
{
    plugin_log(Collectd::LOG_INFO, "reading config...");
    my @config = @{ $_[0]->{children} };
    foreach (@{$config[0]->{children}}) {
        $db_info->{$_->{key}}=$_->{values}[0];
    }
        plugin_log(Collectd::LOG_INFO, Dumper($db_info));
    return 1;
}

sub _getconn
{
#    my $_dbh = DBI->connect("dbi:mysql:database=".$db_info->{schema}.";host=".$db_info->{host}.";port=".$db_info->{port},$db_info->{user},$db_info->{ssap}) or die("can not connect db");
    my $_dbh = DBI->connect("dbi:mysql:database=".$db_info->{schema}.";host=".$db_info->{host}.";mysql_socket=".$db_info->{socket},$db_info->{user},$db_info->{ssap}) or die("can not connect db");
    return $_dbh;
}

sub _getvalue
{
        my $_dbh = shift;
        my $result = $_dbh->selectrow_hashref("$sql_opts");
        plugin_log(Collectd::LOG_INFO, Dumper($result));
        return $result;
}

# check metrics table for detail
sub _fetch_mysql_status
{
        my $_dbh = shift;
        my $sth = $_dbh->prepare("select * from sys.metrics where type='Global Status'");
        $sth->execute;
        my $result = $sth->fetchall_hashref( [ qw(Variable_name Variable_value Type) ] );
        return $result;
}

sub foobar_read
{
      $dbh = _getconn;
    if($dbh){
        plugin_log(Collectd::LOG_INFO, "read loop start...$sql_opts");
        plugin_log(Collectd::LOG_INFO, $dbh);
        my $result = _fetch_mysql_status($dbh);
        while(my ($key,$value) = each(%$result)) {
                while(my ($ikey,$ivalue) = each(%$value)) {
                $mstats->{$key} = $ikey;
                if(!grep /^$key$/,@exclude_status) {
                        my $vl = {};
                        $vl->{'plugin'} = 'Momysql';
                        $vl->{'type'} = 'testme';    # need write define in typedb (testme                  value:GAUGE:0:U)
                        $vl->{'type_instance'} = $key;
                        $vl->{'plugin_instance'} = 'tet_me';
                        $vl->{'time'} = time();
                        $vl->{'interval'} = plugin_get_interval();
                        $vl->{'host'} = $db_info->{host};
                        $vl->{'values'} = [$ikey];
                        plugin_dispatch_values($vl);
                };
            }
        }
                return 1;
    }else{
        plugin_log(Collectd::LOG_ERR, "no db connected,check config file plz!");
        return 1;
    }
}

sub foobar_shutdown
{
    if(!$dbh){
        plugin_log(Collectd::LOG_INFO, "db disconnected!");
        $dbh->disconnect;
    }else{
        plugin_log(Collectd::LOG_ERR, "can not disconnect db!");
    }
}

plugin_register(TYPE_READ, 'Momysql', 'foobar_read');
plugin_register(TYPE_INIT, 'Momysql', 'foobar_init');
plugin_register(TYPE_CONFIG, 'Momysql', 'foobar_config');
plugin_register(TYPE_SHUTDOWN, 'Momysql', 'foobar_shutdown') ;
1;
