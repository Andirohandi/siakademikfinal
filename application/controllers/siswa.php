<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');
class siswa extends CI_Controller {
	function __construct(){
        parent::__construct();
        $this->load->library('session');
		$this->load->model('model_siswa');
		$this->load->model('model_nilai');
    }
	
    public function index()
	{	
		if($this->session->userdata('login_siswa')){
		$session = $this->session->userdata('login_siswa');
	//	echo $session['nisn'];
	//	exit;
		$where['nis'] = $session['nisn'];
		$select_siswa = $this->model_siswa->get_siswa($where);
		$nm_siswa = "";
		$kelas = "";
		$ph ="";
		foreach($select_siswa as $siswa){
			$nm_siswa = $siswa->name;
			$kelas = $siswa->kelas;
			$ph = $siswa->photo;
		}
			$data = array(
				'content'	=> 'siswa/index',
				'kelas'  => $kelas,
				'nm_siswa' => $nm_siswa,
				'photo'	=>$ph
			);
			//echo $this->session->userdata('nama_guru');
		
			$this->load->view($data['content'], $data);
		}else{
		echo "gagal seassion";
		}
	
	}
	public function nilai()
	{
		if($this->session->userdata('login_siswa'))
        {
		//$this->load->model("model_menu");
		$session = $this->session->userdata('login_siswa');
		$where['nis'] = $session['nisn'];
		$select_siswa = $this->model_siswa->get_siswa($where);
		$nm_siswa = "";
		$kelas = "";
		$ph ="";
		foreach($select_siswa as $siswa){
			$nm_siswa = $siswa->name;
			$kelas = $siswa->kelas;
			$ph = $siswa->photo;
		}
        $data['nm_siswa'] = $nm_siswa;
        $data['kelas'] = $kelas;
		$data['photo'] = $ph;
        $wh['r.nis'] = $session['nisn'];
		$data['listsiswa'] = $this->model_siswa->get_nilai($wh);
		
		$this->load->view('siswa/nilai', $data);
		}else{
		redirect('welcome/relogin','refresh');	
		}
	}
	
	function profile(){
		if($this->session->userdata('login_siswa'))
        {
		$session = $this->session->userdata('login_siswa');
		$where['nis'] = $session['nisn'];
		$select_siswa = $this->model_siswa->get_siswa($where);
		$nm_siswa = "";
		$kelas = "";
		$ph ="";
		$tmpt = "";
		$tgl =  "";
		$jenis = "";
		$alamat = "";
		foreach($select_siswa as $siswa){
			$nm_siswa = $siswa->name;
			$kelas = $siswa->kelas;
			$ph = $siswa->photo;
			$tmpt = $siswa->tempat_lahir;
			$tgl = $siswa->tanggal_lahir;
			$jenis = $siswa->jenis_kelamin;
			$alamat = $siswa->alamat;
			
		}
        $data['nm_siswa'] = $nm_siswa;
        $data['nis'] = $session['nisn'];
        $data['kelas'] = $kelas;
		$data['photo'] = $ph;
		$data['tmpt'] = $tmpt;
		$data['tgl']  =$tgl;
		$data['jenis'] = $jenis;
		$data['alamat'] = $alamat;
		
		$id_nis = $session['nisn'];
		
		$data['content'] = 'siswa/profile';
			$this->load->view($data['content'], $data);
		}else{
		redirect('welcome/relogin','refresh');	
		}
	}
	function update_photo() {
		$session = $this->session->userdata('login_siswa');
		$nis = $session['nisn'];
		$folder = "assets/img/siswa/";
		
		if(!empty($_FILES['image']['tmp_name'])){
		$jns_gmb = $_FILES['image']['type'];
		if($jns_gmb=="image/jpeg" || $jns_gmb=="image/jpg" || $jns_gmb=="image/gif" || $jns_gmb=="image/x-png"){
			$nm_gmbr = $_FILES['image']['name'];
			$gambar = $folder . basename($_FILES['image']['name']);
				if(move_uploaded_file($_FILES['image']['tmp_name'], $gambar)){
					$dt['photo'] = $nm_gmbr;
					
					$this->model_siswa->updateDetailsiswa($nis,$dt);
			}else{
				echo "Jenis gambar yang anda kirim salah. Harus .jpg .gif .png";
			}
		}
		
		}
		$this->profile();
		
	}
	
	
    function logout(){  

        $this->session->unset_userdata('login_siswa');
        redirect('login','refresh');
    }
}