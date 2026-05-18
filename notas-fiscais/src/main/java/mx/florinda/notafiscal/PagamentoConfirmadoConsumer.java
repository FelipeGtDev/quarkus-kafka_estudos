package mx.florinda.notafiscal;

import io.smallrye.mutiny.Uni;
import jakarta.enterprise.context.ApplicationScoped;
import org.eclipse.microprofile.reactive.messaging.Incoming;
import org.eclipse.microprofile.rest.client.inject.RestClient;

@ApplicationScoped
public class PagamentoConfirmadoConsumer {

    @RestClient
    public PedidoService pedidoService;

    @Incoming("pagamentosConfirmados")
    public Uni<Void> consume(PagamentoConfirmadoEvent evento) {
        return pedidoService.notaFiscal(evento.pedidoId, evento.valor)
                .onItem().invoke(xml -> System.out.println(xml)).replaceWithVoid();
    }
}
