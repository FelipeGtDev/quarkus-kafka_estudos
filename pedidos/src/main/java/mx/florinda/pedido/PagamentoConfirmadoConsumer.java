package mx.florinda.pedido;

import io.quarkus.hibernate.reactive.panache.Panache;
import io.smallrye.mutiny.Uni;
import jakarta.enterprise.context.ApplicationScoped;
import org.eclipse.microprofile.reactive.messaging.Incoming;

@ApplicationScoped
public class PagamentoConfirmadoConsumer {

    @Incoming("pagamentosConfirmados")
    public Uni<Void> consume(PagamentoConfirmadoEvent evento) {

        return Panache.withTransaction(() ->
                Pedido.<Pedido>findById(evento.pedidoId)
                        .onItem().ifNotNull().invoke(
                                pedido -> pedido.status = StatusPedido.PAGO
                        )
                ).replaceWithVoid();
    }
}


// Como seria essa classe método se fosse no spring boot...

//@Service
//public class PagamentoConfirmadoConsumer {
//
//    @Transactional
//    public void consume(PagamentoConfirmadoEvent evento) {
//
//        Pedido pedido = pedidoRepository.findById(evento.pedidoId);
//
//        if (pedido != null) {
//            pedido.setStatus(StatusPedido.PAGO);
//            pedidoRepository.save(pedido);
//        }
//    }
//}