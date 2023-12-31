const cds = require("@sap/cds");
// module.exports = cds.service.impl(async function () {
//     const { incidents } = this.entities;
//     const sapbackend = await cds.connect.to("sapbackend");
//     this.on("READ", incidents, async (req) => {
//         return await sapbackend.tx(req).send({
//             query: req.query
//         })
//     })
// })

module.exports = async (srv) => {
    const sapbackend = await cds.connect.to("sapbackend");
    const { Incidents } = srv.entities;

    srv.on(["READ"], Incidents, async (req) => {
        let IncidentsQuery = SELECT.from(req.query.SELECT.from).limit(
            req.query.SELECT.limit
        );
        if (req.query.SELECT.where) {
            IncidentsQuery.where(req.query.SELECT.where);
        }

        if (req.query.SELECT.orderBy) {
            IncidentsQuery.orderBy(req.query.SELECT.orderBy)
        }

        let incident = await sapbackend.tx(req).send({
            query: IncidentsQuery,
            // headers: {
            //     Authorization: "Basic c2FwdWk10nNhcHVpNQ=="
            // }
        });

        let incidents = [];
        if (Array.isArray(incident)) {
            incidents = incident;
        } else {
            incidents[0] = incident;
        }
        return incidents;
    });
};


