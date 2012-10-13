""" Client Module
"""
import os
import webdavfs.connection as conn

class Client(object):
    """ Client object
    """
    def __init__(self, webdav_server_uri, webdav_path='.', port=80, realm=''):
        """ Client object
        """
        self._connection_settings = dict(host=webdav_server_uri,
                                         path=webdav_path,
                                         port=port, realm=realm)
        self.connection = None

    def set_connection(self, username='', password=''):
        """ Set up the connection object
        """
        self._connection_settings['username'] = username
        self._connection_settings['password'] = password
        self.connection = conn.Connection(self._connection_settings)

    def download_file(self, file_path, dest_path='.'):
        """ Download a file from file_path to dest_path
        """
        resp, content = self.connection.send_get(file_path)
        file_name = os.path.basename(file_path)
        write_to_path = os.path.join(dest_path, file_name)

        try:
            file_fd = open(write_to_path, 'wb')
            file_fd.write(content)
        except IOError:
            raise
        finally:
            file_fd.close()

        return resp, content

    def chdir(self, directory):
        """ Change directory from whatever current dir is to directory specified
        """
        # Make sure there's a leading '/'
        if not self.connection.path.startswith('/'):
            self.connection.path = '/' + self.connection.path
        self.connection.path = os.path.realpath(
            os.path.join(self.connection.path, directory))
