<?
/**************************************************************************\
* Copyright 2013 Ryan Chan <ryan@rcchan.com>                               *
*                                                                          *
* This program is free software: you can redistribute it and/or modify     *
* it under the terms of the GNU Affero General Public License as           *
* published by the Free Software Foundation, either version 3 of the       *
* License, or (at your option) any later version.                          *
*                                                                          *
* This program is distributed in the hope that it will be useful,          *
* but WITHOUT ANY WARRANTY; without even the implied warranty of           *
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the            *
* GNU Affero General Public License for more details.                      *
*                                                                          *
* You should have received a copy of the GNU Affero General Public License *
* along with this program.  If not, see <http://www.gnu.org/licenses/>.    *
*                                                                          *
*                                                                          *
* Additional permission under the GNU Affero GPL version 3 section 7:      *
*                                                                          *
* If you modify this Program, or any covered work, by linking or           *
* combining it with other code, such other code is not for that reason     *
* alone subject to any of the requirements of the GNU Affero GPL           *
* version 3.                                                               *
\**************************************************************************/
?>
<?
App::uses('Component', 'Controller');
class StatsComponent extends Component {
  function startup(&$controller) {
    $this->controller = $controller; // Stores reference Controller in the component
  }
  public function getStats($domain = ''){
    $item = ClassRegistry::init('Item');
    $data = $item->query('SELECT status, COUNT(*) as count FROM items WHERE domain = :domain OR :domain = "" GROUP BY status', array(':domain' => $domain));
    $stats = array('status' => array(), 'utilization' => array());
    foreach($data as $d) $stats['status'][] = array($d['items']['status'], intval($d[0]['count']));
    $data = $item->query('SELECT utilization, COUNT(*) as count FROM items WHERE status not in ("Disposed", "Decommissioned") and (domain = :domain OR :domain = "") GROUP BY utilization', array(':domain' => $domain));
    foreach($data as $d) $stats['utilization'][] = array($d['items']['utilization'], intval($d[0]['count']));
    $this->controller->set(array('stats' => $stats, 'domain' => $domain, 'domains' => $item->find('list', array('fields' => 'domain', 'group' => 'domain'))));
  }
}
?>