<?php
	
	class model_siswa extends CI_Model {
		
		function __construct()
		{
			parent::__construct();
		}
		
		function get_siswa($arr = ""){
		   $this->load->database();
		   $this->db->select('*');
		   $this->db->from('ref_siswa');
		   $this->db->where($arr);
		   $query = $this -> db -> get();
		//   echo $this->db->last_query();
		//   exit;
			if($query -> num_rows() == 1)
			{
				$result = $query->result();
				return $result;
			}
			else
			{
				return false;
			}
		}
		function get_nilai($arr = ""){
			$this->load->database();
			$this->db->select('r.nis,r.name');
			$this->db->select('p.nm_pelajaran');
			$this->db->select('m.latihan,m.uts,m.uas,m.status');
			
			
			$this->db->from('ref_siswa r');
			$this->db->join('tr_mengajar m','r.nis = m.nis','left');
			$this->db->join('ref_pelajaran p','m.id_mapel = p.id_mapel','left');
			$this->db->where($arr);
			return $this->db->get();
			
			//$query = $this -> db -> get();
			/*
			if($query -> num_rows() == 1)
			{
				$result = $query->result();
				return $result;
			}
			else
			{
				return false;
			}
			*/
		}
	function updateDetailsiswa($id, $data) 
	{
		//delete data yang ada pada table	
		$this->db->where('nis', $id);
		$this->db->update('ref_siswa', $data);
	}
	
	}
?>
