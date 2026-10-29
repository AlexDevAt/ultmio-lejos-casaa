from services.webSocket_config.configSocket import ConnectionManagerNotif
from services.casa.casaService import CasaService
from services.notificacion.notificacionService import NotificacionService
from services.usuario.usuarioService import UsuarioService
from services.reservas.reservas_service import ReservasService
from services.auth.authService import AuthService
from services.resenia.reseniaServicio import ReseniaService
from repository.reservas_repository import ReservarioRepository
from repository.usuario_repository import RepoUsuario
from repository.casa_repository import RepoCasa
from repository.notificacion_repository import NotificacionRepository
from repository.resenia_repository import ReseniaRepository
from repository.auth_repository import AuthRepository

webSocket = ConnectionManagerNotif()

repoReserva = ReservarioRepository()
repoCasa = RepoCasa()
repoUser = RepoUsuario()
repoNoti = NotificacionRepository()
repoResenia = ReseniaRepository()
repoAuth = AuthRepository()

authService = AuthService(repoAuth)
reseniaService = ReseniaService(repoResenia)
usuarioService = UsuarioService(repoUser,repoReserva,repoCasa,repoResenia)
notificacionService = NotificacionService(repoNoti,usuarioService)
casaService = CasaService(repoCasa)
reservaService = ReservasService(repoReserva,notificacionService,casaService,webSocket)

reservaService.obtenerReservasCasa(1)